Class {
	#name : #EDAEventConsumer,
	#superclass : #EDAMessageConsumer,
	#category : #'EDA-Events-Consumers'
}

{ #category : #'instance creation' }
EDAEventConsumer class >> busListener: aBusListener materializer: aMaterializer dispatcher: aDispatcher [
	^ self
		busListener: aBusListener
		materializer: aMaterializer
		dispatcher: aDispatcher
		strategy: EDAEventConsumingErrorBehavior strategy
]
