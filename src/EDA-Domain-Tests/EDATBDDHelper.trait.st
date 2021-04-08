Trait {
	#name : #EDATBDDHelper,
	#traits : 'EDATLogging + EDATRegexHelper',
	#classTraits : 'EDATLogging classTrait + EDATRegexHelper classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #helpers }
EDATBDDHelper >> assertEvents: resultingEvents matchExpected: expectedEvents [
	self assert: resultingEvents size equals: expectedEvents size.
	resultingEvents
		keysAndValuesDo: [ :i :actual | 
			| expected |
			expected := expectedEvents at: i.
			self discardDateCreated: expected.
			self discardAgent: expected.
			self assertEvent: expected equals: actual ]
]

{ #category : #helpers }
EDATBDDHelper >> buildCommandConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDACommandConsumer
		busListener: mock
		commandMaterializer: EDAJsonCommandMaterializer new
		commandDispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: anEventStore
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
		usingStrategy: EDAThrowError greaseString
]

{ #category : #BDD }
EDATBDDHelper >> givenEvents: pastEvents processingThem: aProcessingPastEventsBlock whenReceiveMessage: aString processingIt: aMessageBlock thenEvents: expectedResultingEvents processingThem: aProcessingExpectedEventsBlock [
	| commandConsumer resultingEvents eventStore expectedEvents eventsToSave originalEventStores aMessage |
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ self useEventStore: eventStore.
	eventsToSave := aProcessingPastEventsBlock
		value: pastEvents
		value: eventStore.
	eventStore saveEvents: eventsToSave.
	commandConsumer := self
		buildCommandConsumerWithEventStore: eventStore.
	expectedEvents := aProcessingExpectedEventsBlock value: expectedResultingEvents value: eventStore.
	aMessage := aMessageBlock value: eventsToSave value: aString.
	resultingEvents := self
		consumeMessage: aMessage
		using: commandConsumer.
	self assertEvents: resultingEvents matchExpected: expectedEvents ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #BDD }
EDATBDDHelper >> givenEvents: historicalEvents processingThem: aProcessingBlock whenReceiveMessage: aMessage thenEvents: expectedResultingEvents [
	| commandConsumer resultingEvents eventStore expectedEvents eventsToSave originalEventStores |
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ self useEventStore: eventStore.
	eventsToSave := aProcessingBlock
		value: historicalEvents
		value: eventStore.
	eventStore saveEvents: eventsToSave.
	commandConsumer := self
		buildCommandConsumerWithEventStore: eventStore.
	expectedEvents := self
		processEvents: expectedResultingEvents
		usingEventStore: eventStore.
	resultingEvents := self
		consumeMessage: aMessage
		using: commandConsumer.
	self assertEvents: resultingEvents matchExpected: expectedEvents ]
		ensure: [ self restoreEventStores: originalEventStores ]
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
