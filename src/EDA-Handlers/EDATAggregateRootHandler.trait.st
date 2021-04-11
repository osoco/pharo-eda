Trait {
	#name : #EDATAggregateRootHandler,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Handlers-Handlers'
}

{ #category : #adding }
EDATAggregateRootHandler classSide >> addVersionToEvents: producedEvents usingEventStore: anEventStore [
	| result versions aggregates |
	result := OrderedCollection new.
	versions := Dictionary new.
	aggregates := Dictionary new.
	producedEvents
		do: [ :evt | 
			| newEvent previousVersion newVersion aggRoot criteria |
			aggRoot := aggregates
				at: evt aggregateRootClass greaseString , evt id greaseString
				ifAbsentPut: [ criteria := Dictionary with: 'id' -> evt id.
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
EDATAggregateRootHandler classSide >> buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria andEventStore: anEventStore [
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
EDATAggregateRootHandler >> buildAggregateRootFrom: anInstance andAggregateRootClass: anAggregateRootClass [
	| result |
	result := self class
		buildAggregateRootOfTenant: anInstance tenant
		ofAggregateRootClass: anAggregateRootClass
		withCriteria: (anAggregateRootClass aggregateSelectionCriteriaFor: anInstance)
		andEventStore: self eventStore.
	^ result
]

{ #category : #'aggregate creation' }
EDATAggregateRootHandler >> buildAggregateRootOfTenant: aTenant ofAggregateRootClass: anAggregateRootClass withCriteria: aCriteria [
	^ self class
		buildAggregateRootOfTenant: aTenant
		ofAggregateRootClass: anAggregateRootClass
		withCriteria: aCriteria
		andEventStore: self eventStore
]

{ #category : #handling }
EDATAggregateRootHandler >> handle: aCommand withErrorStrategy: strategy [
	| aggregateRoot processedEvents producedEvents handlingResult |
	[ aggregateRoot := self buildAggregateRootFrom: aCommand.
	self checkCommand: aCommand forAggregateRoot: aggregateRoot.
	handlingResult := self
		delegateHandlingOfCommand: aCommand
		toAggregate: aggregateRoot.
	producedEvents := handlingResult isCollection
		ifTrue: [ handlingResult ]
		ifFalse: [ OrderedCollection with: handlingResult ].
	processedEvents := self
		processGeneratedEvents: producedEvents
		for: aCommand
		onAggregateRoot: aggregateRoot.
	self eventBus produceEvents: processedEvents ]
		on: Error - Break
		do: [ :exception | 
			self
				manageError: exception
				forCommand: aCommand
				usingErrorStrategy: strategy ].
	^ processedEvents
]
