Class {
	#name : #EDAComplexCommandBuilder,
	#superclass : #EDABaseCommandBuilder,
	#category : #'EDA-Commands-Tests'
}

{ #category : #public }
EDAComplexCommandBuilder >> commandClassPrefix [
	"Returns the class prefix for application's commands"

	^ 'EDA'
]

{ #category : #helpers }
EDAComplexCommandBuilder >> extractLevels: aCollection [
    "Extracts the levels from given list of maps"
    | result |
    result := { } asOrderedCollection.
    aCollection collect: [ :item | result add: (self extractLevel: item) ].
    ^ result
]
