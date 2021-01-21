Class {
	#name : #RegexJsonArray,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'testCase',
		'array'
	],
	#category : 'EDA-Commands-Tests'
}

{ #category : #'instance creation' }
RegexJsonArray class >> newFrom: anArray andTestCase: aTestCase [
	| result |
	result := self new.
	result array: (Array newFrom: anArray).
	result testCase: aTestCase.
	^ result
]

{ #category : #accessing }
RegexJsonArray >> array [
	^ array
]

{ #category : #accessing }
RegexJsonArray >> array: anArray [
	array := anArray
]

{ #category : #accessing }
RegexJsonArray >> arrayAt: index [
	"Answer the element at given index."

	| value result |
	value := self at: index.
	(value isKindOf: Array)
		ifTrue: [ result := value ]
		ifFalse: [ result := #(value) ].
	^ result
]

{ #category : #accessing }
RegexJsonArray >> assertItemMatches: anItem at: anIndex [
	| result |
	result := true.
	^ result
]

{ #category : #accessing }
RegexJsonArray >> assertMatches: anArray [
	| result |
	result := true.
	anArray doWithIndex: [ :item :i | result := result and: [ self assertItemMatches: item at: i ] ].
	^ result
]

{ #category : #accessing }
RegexJsonArray >> at: index [
	^ self array at: index

]

{ #category : #copying }
RegexJsonArray >> copyEmpty [
	^ self new
]

{ #category : #accessing }
RegexJsonArray >> testCase [
	^ testCase
]

{ #category : #accessing }
RegexJsonArray >> testCase: aTestCase [
	testCase := aTestCase
]
