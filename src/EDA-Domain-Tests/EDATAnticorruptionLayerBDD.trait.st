Trait {
	#name : #EDATAnticorruptionLayerBDD,
	#traits : 'EDATLogging + EDATRegexHelper + EDATBDDHelper',
	#category : #'EDA-Domain-Tests'
}

{ #category : #helpers }
EDATAnticorruptionLayerBDD >> buildCommandConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDAMessageConsumer
		busListener: mock
		materializer: EDACommandMaterializer new
		dispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
]

{ #category : #BDD }
EDATAnticorruptionLayerBDD >> givenAnticorruptionLayer: aSymbol whenReceivingExternalEvent: anEvent then: aBlock [
	| anticorruptionLayer |
	anticorruptionLayer := (Class environment at: aSymbol) new.
	aBlock value: anticorruptionLayer.
]

{ #category : #BDD }
EDATAnticorruptionLayerBDD >> givenEvents: pastEvents whenReceiveMessage: aString thenProjections: expectedProjections [
	| eventStore originalEventStores |
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ | eventConsumer resultingProjections |
	self useEventStore: eventStore.
	eventStore saveEvents: pastEvents.
	eventConsumer := self buildEventConsumerWithEventStore: eventStore.
	resultingProjections := self consumeMessage: aString using: eventConsumer.
	self
		assertProjections: resultingProjections
		matchExpected: expectedProjections ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #BDD }
EDATAnticorruptionLayerBDD >> givenEvents: pastEvents whenReceivingExternalEvent: anEvent thenEvents: expectedEvents [
	self
		givenEvents: pastEvents
		processingThem: [ :evts :eventStore | evts ]
		whenReceiveMessage: (self serializeEvent: anEvent)
		processingIt: [ :events :msg | msg ]
		thenEvents: expectedEvents
		processingThem: [ :events :eventStore | events ]
]
