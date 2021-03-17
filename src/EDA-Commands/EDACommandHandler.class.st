Class {
	#name : #EDACommandHandler,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'eventStore',
		'eventBus'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #handling }
EDACommandHandler >> buildAggregateRootFromCommand: aCommand [
	^ self buildAggregateRootFromCommand: aCommand andAggregateRootClass: (self retrieveAggregateRootClass: aCommand)
]

{ #category : #handling }
EDACommandHandler >> buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass [
	| result events startRetrievingEventsTimer startBuildingAggregateTimer |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Retrieving events for ';
						nextPutAll: anAggregateRootClass greaseString;
						nextPutAll: ' matching ';
						nextPutAll: aCommand aggregateSelectionCriteria greaseString;
						nextPutAll: '.' ]).
	startRetrievingEventsTimer := DateAndTime now.
	events := eventStore
		findEventsOfTenant: aCommand tenant
		ofAggregate: anAggregateRootClass
		whereCriteria: aCommand aggregateSelectionCriteria.
	startBuildingAggregateTimer := DateAndTime now.
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: events size greaseString;
						nextPutAll: ' event(s) retrieved in ';
						nextPutAll:
							(startBuildingAggregateTimer - startRetrievingEventsTimer)
								totalSeconds greaseString;
						nextPutAll: ' second(s).' ]).
	result := anAggregateRootClass new.
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Applying ';
						nextPutAll: events size greaseString;
						nextPutAll: ' event(s) to an empty ';
						nextPutAll: anAggregateRootClass greaseString;
						nextPut: $. ]).
	result applyEvents: events.
	(result isDeleted and: [ aCommand isCreate ]) ifTrue: [ result := anAggregateRootClass new ].
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Aggregate ';
						nextPutAll: result greaseString;
						nextPutAll: ' successfully built in ';
						nextPutAll:
							(DateAndTime now - startBuildingAggregateTimer) totalSeconds
								greaseString;
						nextPutAll: ' second(s).' ]).
	result version = aCommand aggregateRootVersion
		ifFalse: [ self
				logWarningMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Aggregate root''s version (';
								nextPutAll: result version greaseString;
								nextPutAll: ') does not match command''s (';
								nextPutAll: aCommand aggregateRootVersion greaseString;
								nextPutAll: ').' ]) ].
	^ result
]

{ #category : #handling }
EDACommandHandler >> checkCreateCommand: aCommand forAggregateRoot: anAggregateRoot [
	aCommand isCreate
		ifTrue: [ aCommand aggregateRootVersion = 0
				ifFalse: [ self
						logWarningMessage:
							'Received create command with aggregate root version '
								, aCommand aggregateRootVersion greaseString.
					aCommand aggregateRootVersion: 0 ] ].
	(aCommand isCreate not and: [ anAggregateRoot brandNew ])
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: anAggregateRoot class greaseString;
								nextPutAll: ' with id ';
								nextPutAll: aCommand aggregateRootId greaseString;
								nextPutAll: ' does not exist in tenant ';
								nextPutAll: aCommand tenant ])
				andThrow: EDAInvalidCommandMessage ]
]

{ #category : #handling }
EDACommandHandler >> delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot [
	self subclassResponsibility
]

{ #category : #accessing }
EDACommandHandler >> eventBus [
	^ eventBus
]

{ #category : #accessing }
EDACommandHandler >> eventBus: anObject [
	eventBus := anObject
]

{ #category : #accessing }
EDACommandHandler >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDACommandHandler >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #handling }
EDACommandHandler >> handle: aCommand withErrorStrategy: strategy [
	| aggregateRoot processedEvents producedEvents handlingResult |
	[ aggregateRoot := self buildAggregateRootFromCommand: aCommand.
	aggregateRoot isDeleted
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: aCommand aggregateRootClass greaseString;
								nextPutAll: ' with id ';
								nextPutAll: aCommand aggregateRootId greaseString;
								nextPutAll: ' is already deleted' ])
				andThrow: EDAInvalidCommandMessage ].
	self checkCreateCommand: aCommand forAggregateRoot: aggregateRoot.
	producedEvents := OrderedCollection new.
	handlingResult := self
		delegateHandlingOfCommand: aCommand
		toAggregate: aggregateRoot.
	((handlingResult isKindOf: EDAEventSourcingEvent)
		or: [ handlingResult isKindOf: OrderedCollection ])
		ifTrue: [ producedEvents add: handlingResult.
			producedEvents := producedEvents flattened.
			processedEvents := self
				processGeneratedEvents: producedEvents
				forCommand: aCommand
				onAggregateRoot: aggregateRoot ].
	eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception |
			self
				manageError: exception
				forCommand: aCommand
				usingErrorStrategy: strategy ].
	^ self
]

{ #category : #handling }
EDACommandHandler >> invokeMethodHandlerWith: aCommand on: aReceiver [
	^ self subclassResponsibility 
	
]

{ #category : #handling }
EDACommandHandler >> processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: anAggregateRoot [
	| message |
	message := ''.
	producedEvents
		do: [ :event |
			event aggregateRootVersion: aCommand aggregateRootVersion + 1.
			message := message , ' ' , event class name ].
	self
		logInfoMessage: 'Produced event(s): ' , message greaseString , '.'.
	self flag: #TODO.	"TODO: transaction including eventstore and eventbus operations"
	eventStore saveEvents: producedEvents onAggregate: anAggregateRoot.
	self logInfoMessage: 'Projecting events...'.
	(EDACompositeProjector ofTenant: aCommand tenant withAllProjectorsAndEventStore: eventStore)
		projectFilteredEvents: producedEvents
		ofTenant: aCommand tenant.
	self logInfoMessage: 'Done'.
	^ producedEvents
]

{ #category : #handling }
EDACommandHandler >> retrieveAggregateRootClass: aCommand [
	^ aCommand aggregateRootClass
]
