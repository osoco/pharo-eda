Class {
	#name : #EDAEventBuilderRegistry,
	#superclass : #Object,
	#instVars : [
		'mapping'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'EDA-Events-Builders'
}

{ #category : #singleton }
EDAEventBuilderRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ self uniqueInstance: self new. uniqueInstance ]
]

{ #category : #singleton }
EDAEventBuilderRegistry class >> uniqueInstance: anInstance [
	uniqueInstance := anInstance
]

{ #category : #API }
EDAEventBuilderRegistry >> doInitialize [
	self initializeMapping
]

{ #category : #initialization }
EDAEventBuilderRegistry >> initialize [
	| result |
	result := super initialize.
	self doInitialize.
	^ result
]

{ #category : #API }
EDAEventBuilderRegistry >> initializeMapping [
	"Initializes the mapping"

	mapping := Dictionary new
]

{ #category : #API }
EDAEventBuilderRegistry >> lookupBuilder: eventName [
	"Retrieves the builder for given event name"

	^ self mapping at: eventName ifAbsent: [ nil ]
]

{ #category : #accessing }
EDAEventBuilderRegistry >> mapping [
	"Retrieves the mapping, initializing it if necessary"

	mapping ifNil: [ self initializeMapping ].
	^ mapping
]
