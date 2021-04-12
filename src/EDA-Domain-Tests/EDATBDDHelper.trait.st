Trait {
	#name : #EDATBDDHelper,
	#traits : 'EDATLogging + EDATRegexHelper',
	#classTraits : 'EDATLogging classTrait + EDATRegexHelper classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #assertions }
EDATBDDHelper >> assertEvent: actual equals: expected [
	| diff |
	diff := expected odDiff: actual.
	^ self
		assert: (diff isNil or: [ diff identical ])
		description: [ diff greaseString ]
]

{ #category : #helpers }
EDATBDDHelper >> assertEvents: resultingEvents matchExpected: expectedEvents [
	self assert: resultingEvents size equals: expectedEvents size.
	resultingEvents
		keysAndValuesDo: [ :i :actual | 
			self assert: (expectedEvents select: [ :expected | 
			self discardDateCreated: expected.
			self discardAgent: expected.
			self is: expected equalTo: actual ]) isNotEmpty ]
]

{ #category : #helpers }
EDATBDDHelper >> buildCommandConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDAMessageConsumer
		busListener: mock
		materializer: EDAJsonCommandMaterializer new
		dispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
]

{ #category : #helpers }
EDATBDDHelper >> buildConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDAMessageConsumer
		busListener: mock
		commandMaterializer: EDAJsonCommandMaterializer new
		commandDispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
		eventMaterializer: EDAJsonEventMaterializer new
		eventDispatcher:
			(EDAApplication
				buildEventDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
]

{ #category : #helpers }
EDATBDDHelper >> buildEventSerializer [
	^ EDAJsonEventSerializer new
]

{ #category : #helpers }
EDATBDDHelper >> consumeMessage: aMessage using: aCommandConsumer [
	^ aCommandConsumer
		consumeMessage: aMessage
		usingStrategyForCommands: EDAThrowError greaseString
		andStrategyForEvents: EDAThrowError greaseString
]

{ #category : #helpers }
EDATBDDHelper >> discardAgent: anEvent [
	(anEvent respondsTo: #agent:)
		ifTrue: [ anEvent agent: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> discardDateCreated: anEvent [
	(anEvent respondsTo: #dateCreated:)
		ifTrue: [ anEvent dateCreated: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> filterPastEvents: events ofAggregate: anAggregateRootSymbol [
	^ events
		select:
			[ :e | e aggregateRootClass greaseString asSymbol = anAggregateRootSymbol ]
]

{ #category : #BDD }
EDATBDDHelper >> givenEvents: pastEvents processingThem: aProcessingPastEventsBlock whenReceiveMessage: aString processingIt: aMessageBlock thenEvents: expectedResultingEvents processingThem: aProcessingExpectedEventsBlock [
	| consumer resultingEvents eventStore expectedEvents eventsToSave originalEventStores aMessage |
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ self useEventStore: eventStore.
	eventsToSave := aProcessingPastEventsBlock
		value: pastEvents
		value: eventStore.
	eventStore saveEvents: eventsToSave.
	consumer := self
		buildConsumerWithEventStore: eventStore.
	expectedEvents := aProcessingExpectedEventsBlock
		value: expectedResultingEvents
		value: eventStore.
	aMessage := aMessageBlock value: eventsToSave value: aString.
	resultingEvents := self
		consumeMessage: aMessage
		using: consumer.
	self assertEvents: resultingEvents matchExpected: expectedEvents ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #assertions }
EDATBDDHelper >> is: actual equalTo: expected [
	| diff |
	diff := expected odDiff: actual.
	^ diff isNil or: [ diff identical ]

]

{ #category : #helpers }
EDATBDDHelper >> restoreEventStores: aDictionary [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: (aDictionary at: c greaseString asSymbol) ]
]

{ #category : #helpers }
EDATBDDHelper >> retrieveEventStores [
	| result |
	result := Dictionary new.
	EDAAggregateRepository
		allSubclassesDo: [ :c | result at: c greaseString asSymbol put: c eventStore ].
	^ result
]

{ #category : #helpers }
EDATBDDHelper >> serializeEvent: anEvent [
	^ self buildEventSerializer serialize: anEvent
]

{ #category : #helpers }
EDATBDDHelper >> useEventStore: anEventStore [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: anEventStore ]
]
