Trait {
	#name : #EDATAnticorruptionLayerBDD,
	#traits : 'EDATLogging + EDATRegexHelper + EDATBDDHelper',
	#classTraits : 'EDATLogging classTrait + EDATRegexHelper classTrait + EDATBDDHelper classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #helpers }
EDATAnticorruptionLayerBDD >> buildCommandConsumerWithEventStore: anEventStore [
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

{ #category : #BDD }
EDATAnticorruptionLayerBDD >> givenAnticorruptionLayer: aSymbol whenReceivingExternalEvent: anEvent then: aBlock [
	| anticorruptionLayer |
	anticorruptionLayer := (Class environment at: aSymbol) new.
	aBlock value: anticorruptionLayer.
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
