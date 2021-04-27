Class {
	#name : #EDACommandConsumer,
	#superclass : #EDAMessageConsumer,
	#category : #'EDA-Commands-Consumers'
}

{ #category : #'instance creation' }
EDACommandConsumer class >> busListener: aBusListener materializer: aMaterializer dispatcher: aDispatcher [
	^ self
		busListener: aBusListener
		materializer: aMaterializer
		dispatcher: aDispatcher
		strategy: EDACommandConsumingErrorBehavior strategy
]
