Class {
	#name : #EDARegexJsonArray,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'testCase',
		'array'
	],
	#category : 'EDA-Commands-Tests'
}

{ #category : #'instance creation' }
EDARegexJsonArray class >> newFrom: anArray andTestCase: aTestCase [
	| result |
	result := self new.
	result array: (Array newFrom: anArray).
	result testCase: aTestCase.
	^ result
]

{ #category : #accessing }
EDARegexJsonArray >> array [
	^ array
]

{ #category : #accessing }
EDARegexJsonArray >> array: anArray [
	array := anArray
]

{ #category : #accessing }
EDARegexJsonArray >> arrayAt: index [
	"Answer the element at given index."

	| value result |
	value := self at: index.
	(value isKindOf: Array)
		ifTrue: [ result := value ]
		ifFalse: [ result := #(value) ].
	^ result
]

{ #category : #accessing }
EDARegexJsonArray >> assertItemMatches: anItem at: anIndex [
	| result |
	result := true.
	^ result
]

{ #category : #accessing }
EDARegexJsonArray >> assertMatches: anArray [
	| result |
	result := true.
	anArray doWithIndex: [ :item :i | result := result and: [ self assertItemMatches: item at: i ] ].
	^ result
]

{ #category : #accessing }
EDARegexJsonArray >> at: index [
	^ self array at: index

]

{ #category : #copying }
EDARegexJsonArray >> copyEmpty [
	^ self new
]

{ #category : #accessing }
EDARegexJsonArray >> testCase [
	^ testCase
]

{ #category : #accessing }
EDARegexJsonArray >> testCase: aTestCase [
	testCase := aTestCase
]
