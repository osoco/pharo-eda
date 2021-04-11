Class {
	#name : #EDAErrorBehavior,
	#superclass : #Object,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#classInstVars : [
		'strategy'
	],
	#category : #'EDA-Errors-Behaviors'
}

{ #category : #accessing }
EDAErrorBehavior class >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAErrorBehavior class >> strategy: aStrategy [
	strategy := aStrategy
]
