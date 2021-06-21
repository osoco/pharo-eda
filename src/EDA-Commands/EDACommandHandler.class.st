Class {
	#name : #EDACommandHandler,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATErrorHelper + EDATRepository',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATErrorHelper classTrait + EDATRepository classTrait',
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
		do: [ :evt | 
			| newEvent previousVersion newVersion aggRoot criteria |
			aggRoot := aggregates
				at: evt aggregateRootClass greaseString , evt id greaseString
				ifAbsentPut: [ criteria := Dictionary with: ('id' -> evt id).
					self
						buildAggregateRootOfTenant: evt tenant
						ofAggregateRootClass: evt aggregateRootClass
						withCriteria: criteria
						andEventStore: anEventStore ].
			previousVersion := versions
				at: aggRoot class greaseString , aggRoot id greaseString
				ifAbsent: [ aggRoot version ].
			newVersion := aggRoot newVersionAfter: previousVersion.
			newEvent := EDAVersionedEvent forEvent: evt andVersion: newVersion.
			result add: newEvent.
			versions
				at: aggRoot class greaseString , aggRoot id greaseString
				put: newVersion ].
	^ result
]

{ #category : #handling }
EDACommandHandler class >> buildAggregateRootOfClass: anAggregateRootClass withCriteria: aCriteria andEventStore: anEventStore [
	| nonDeletedAggregates events startRetrievingEventsTimer startBuildingAggregateTimer eventsById aggregate |
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
		findEventsOfAggregate: anAggregateRootClass
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
	eventsById := self groupEventsById: events.
	nonDeletedAggregates := eventsById keys
		collect: [ :id | 
			| idEvents |
			idEvents := anEventStore
				findEventsOfAggregate: anAggregateRootClass
				whereId: id.
			anAggregateRootClass new applyEvents: idEvents ]
		thenReject: [ :aggr | aggr isDeleted ].
	nonDeletedAggregates size > 1
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Too many non deleted aggregates founds matching ';
								nextPutAll: aCriteria greaseString;
								nextPutAll: '.' ])
				andThrow: EDATooManyAggregatesForCriteria ].
	aggregate := nonDeletedAggregates
		ifEmpty: [ anAggregateRootClass new ]
		ifNotEmpty: [ :ndAggr | ndAggr anyOne ].
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Aggregate ';
						nextPutAll: aggregate greaseString;
						nextPutAll: ' successfully built in ';
						nextPutAll:
							(DateAndTime now - startBuildingAggregateTimer) totalSeconds
								greaseString;
						nextPutAll: ' second(s).' ]).
	^ aggregate
]

{ #category : #handling }
EDACommandHandler class >> buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria andEventStore: anEventStore [
	| nonDeletedAggregates events startRetrievingEventsTimer startBuildingAggregateTimer eventsById aggregate |
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
	eventsById := self groupEventsById: events.
	nonDeletedAggregates := eventsById keys
		collect: [ :id | 
			| idEvents |
			idEvents := anEventStore
				findEventsOfTenant: aTenant
				ofAggregate: anAggregateRootClass
				whereId: id.
			anAggregateRootClass new applyEvents: idEvents ]
		thenReject: [ :aggr | aggr isDeleted ].
	nonDeletedAggregates size > 1
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Too many non deleted aggregates founds matching ';
								nextPutAll: aCriteria greaseString;
								nextPutAll: '.' ])
				andThrow: EDATooManyAggregatesForCriteria ].
	aggregate := nonDeletedAggregates
		ifEmpty: [ anAggregateRootClass new ]
		ifNotEmpty: [ :ndAggr | ndAggr anyOne ].
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Aggregate ';
						nextPutAll: aggregate greaseString;
						nextPutAll: ' successfully built in ';
						nextPutAll:
							(DateAndTime now - startBuildingAggregateTimer) totalSeconds
								greaseString;
						nextPutAll: ' second(s).' ]).
	^ aggregate
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
EDACommandHandler >> checkCommand: aCommand forAggregateRoot: anAggregateRoot [

	aCommand checkForAggregateRoot: anAggregateRoot.
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
	self checkCommand: aCommand forAggregateRoot: aggregateRoot.
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
