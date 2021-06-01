Class {
	#name : #EDAErrorBehavior,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
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
