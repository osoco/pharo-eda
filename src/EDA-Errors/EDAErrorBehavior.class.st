Class {
	#name : #EDAErrorBehavior,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#classInstVars : [
		'strategy'
	],
	#category : 'EDA-Errors-Behaviors'
}

{ #category : #accessing }
EDAErrorBehavior class >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAErrorBehavior class >> strategy: aStrategy [
	strategy := aStrategy
]
