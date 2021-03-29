Class {
	#name : #EDACommandHandler,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'eventStore',
		'eventBus',
		'projectorClass'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #handling }
EDACommandHandler class >> addVersionToEvents: producedEvents usingEventStore: anEventStore [
	| result versions aggregates |
	result := OrderedCollection new.
	versions := Dictionary new.
	aggregates := Dictionary new.
	producedEvents
		do: [ :e | 
			| newEvent previousVersion newVersion aggRoot criteria |
			aggRoot := aggregates
				at: e aggregateRootClass greaseString , e id greaseString
				ifAbsent: [ criteria := Dictionary new.
					criteria at: 'id' put: e id.
					self
						buildAggregateRootOfTenant: e tenant
						ofAggregateRootClass: e aggregateRootClass
						withCriteria: criteria
						andEventStore: anEventStore ].
			aggregates
				at: e aggregateRootClass greaseString , e id greaseString
				put: aggRoot.
			previousVersion := versions
				at: aggRoot class greaseString , aggRoot id greaseString
				ifAbsent: [ aggRoot version ].
			newVersion := aggRoot newVersionAfter: previousVersion.
			newEvent := EDAVersionedEvent forEvent: e andVersion: newVersion.
			result add: newEvent.
			versions
				at: aggRoot class greaseString , aggRoot id greaseString
				put: newVersion ].
	^ result
]

{ #category : #handling }
EDACommandHandler class >> buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria andEventStore: anEventStore [
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
						nextPutAll: aCriteria greaseString;
						nextPutAll: '.' ]).
	startRetrievingEventsTimer := DateAndTime now.
	events := anEventStore
		findEventsOfTenant: aTenant
		ofAggregate: anAggregateRootClass
		whereCriteria: aCriteria.
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
	result applyEvents: events.
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
	^ result
]

{ #category : #handling }
EDACommandHandler >> buildAggregateRootFromCommand: aCommand [
	^ self buildAggregateRootFromCommand: aCommand andAggregateRootClass: (self retrieveAggregateRootClass: aCommand)
]

{ #category : #handling }
EDACommandHandler >> buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass [
	| result |
	result := self class
		buildAggregateRootOfTenant: aCommand tenant
		ofAggregateRootClass: anAggregateRootClass
		withCriteria: aCommand aggregateSelectionCriteria
		andEventStore: eventStore.
	(result isDeleted and: [ aCommand isCreate ])
		ifTrue: [ result := anAggregateRootClass new ].
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

{ #category : #helpers }
EDACommandHandler >> buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria [
	^ self class buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria andEventStore: eventStore
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
								nextPutAll: aCommand tenant greaseString ])
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
	handlingResult := self
		delegateHandlingOfCommand: aCommand
		toAggregate: aggregateRoot.
	producedEvents := handlingResult isCollection
		ifTrue: [ handlingResult ]
		ifFalse: [ OrderedCollection with: handlingResult ].
	processedEvents := self
		processGeneratedEvents: producedEvents
		forCommand: aCommand
		onAggregateRoot: aggregateRoot.
	eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception | 
			self
				manageError: exception
				forCommand: aCommand
				usingErrorStrategy: strategy ].
	^ processedEvents
]

{ #category : #handling }
EDACommandHandler >> invokeMethodHandlerWith: aCommand on: aReceiver [
	^ self subclassResponsibility 
	
]

{ #category : #handling }
EDACommandHandler >> processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: anAggregateRoot [
	| message versionedEvents |
	message := ''.
	producedEvents
		do: [ :event | message := message , ' ' , event class name ].
	self
		logInfoMessage: 'Produced event(s): ' , message greaseString , '.'.
	self flag: #TODO.	"TODO: transaction including eventstore and eventbus operations"
	versionedEvents := self class
		addVersionToEvents: producedEvents
		usingEventStore: eventStore.
	eventStore saveEvents: versionedEvents.
	self logInfoMessage: 'Projecting events...'.
	(self projectorClass
		ofTenant: aCommand tenant
		withAllProjectorsAndEventStore: eventStore)
		projectFilteredEvents: versionedEvents
		ofTenant: aCommand tenant.
	self logInfoMessage: 'Done'.
	^ producedEvents
]

{ #category : #accessing }
EDACommandHandler >> projectorClass [
	^ projectorClass ifNil: [ EDACompositeProjector ]
]

{ #category : #accessing }
EDACommandHandler >> projectorClass: anObject [
	projectorClass := anObject
]

{ #category : #handling }
EDACommandHandler >> retrieveAggregateRootClass: aCommand [
	^ aCommand aggregateRootClass
]
