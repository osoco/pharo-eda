Class {
	#name : #EDAComplexCommandBuilder,
	#superclass : #EDABaseCommandBuilder,
	#category : 'EDA-Commands-Tests'
}

{ #category : #'as yet unclassified' }
EDAComplexCommandBuilder >> extractLevels: aCollection [
    "Extracts the levels from given list of maps"
    | result |
    result := { } asOrderedCollection.
    aCollection collect: [ :item | result add: (self extractLevel: item) ].
    ^ result
]
