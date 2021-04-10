Class {
	#name : #EDAComplexCommand,
	#superclass : #EDAUserCommand,
	#instVars : [
		'levels'
	],
	#category : #'EDA-Commands-Tests'
}

{ #category : #comparing }
EDAComplexCommand >> = aCommand [
	^ self class = aCommand class
		and: [ self commandId = aCommand commandId 
		and: self levels = aCommand levels ]
]

{ #category : #comparing }
EDAComplexCommand >> hash [
	^ (super hash bitXor: levels hash).
]

{ #category : #accessing }
EDAComplexCommand >> levels [
	^ levels
]

{ #category : #accessing }
EDAComplexCommand >> levels: aCollection [ 
	levels := aCollection
]
