Class {
	#name : #EDAComplexCommand,
	#superclass : #EDAUserCommand,
	#instVars : [
		'levels'
	],
	#category : 'EDA-Commands-Tests'
}

{ #category : #'as yet unclassified' }
EDAComplexCommand >> = aCommand [
  ^ ((self class = aCommand class)
     and: (self commandId = aCommand commandId))
    and: (self levels = aCommand levels)

]

{ #category : #'as yet unclassified' }
EDAComplexCommand >> hash [
	^ (super hash bitXor: levels hash).
]

{ #category : #'as yet unclassified' }
EDAComplexCommand >> levels [
	^ levels
]

{ #category : #'as yet unclassified' }
EDAComplexCommand >> levels: aCollection [ 
	levels := aCollection
]
