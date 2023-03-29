Class {
	#name : #EDAEventProducerBehavior,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#classInstVars : [
		'strategy'
	],
	#category : #'EDA-Messaging-EventProducer-Behavior'
}

{ #category : #'instance creation' }
EDAEventProducerBehavior class >> eventProducerClass [
	^ self class environment at: strategy asSymbol
]

{ #category : #'instance creation' }
EDAEventProducerBehavior class >> eventProducerForEDAApplication: anEDAApplication [
	^ self eventProducerClass forEDAApplication: anEDAApplication
]

{ #category : #accessing }
EDAEventProducerBehavior class >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAEventProducerBehavior class >> strategy: anObject [
	strategy := anObject
]
