Class {
	#name : #EDATypeAttributeBuilder,
	#superclass : #EDACommandBuilder,
	#category : #'EDA-Commands-Builders'
}

{ #category : #accessing }
EDATypeAttributeBuilder class >> priority [
	^ 100
]

{ #category : #testing }
EDATypeAttributeBuilder >> retrieveType: aDictionary [
	^ aDictionary at: #type ifAbsent: [ nil ]
]
