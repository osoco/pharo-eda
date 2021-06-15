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

{ #category : #reading }
EDACommandConsumer >> consumeMessage: aMessageString usingStrategyForCommands: aStrategyForCommands andStrategyForEvents: aStrategyForEvents [
	^ self consumeMessage: aMessageString usingStrategy: aStrategyForCommands
]
