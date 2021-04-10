Class {
	#name : #EDAEventBuilderRegistry,
	#superclass : #Object,
	#instVars : [
		'mapping'
	],
	#category : #'EDA-Events-Builders'
}

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

	^ self mapping at: eventName ifAbsent: [ EDADefaultEventBuilder ]
]

{ #category : #accessing }
EDAEventBuilderRegistry >> mapping [
	"Retrieves the mapping, initializing it if necessary"

	mapping ifNil: [ self initializeMapping ].
	^ mapping
]
