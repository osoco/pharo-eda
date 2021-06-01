Class {
	#name : #EDARegexJsonDictionary,
	#superclass : #Dictionary,
	#traits : 'EDATJsonRegexHelper',
	#classTraits : 'EDATJsonRegexHelper classTrait',
	#instVars : [
		'testCase',
		'dict'
	],
	#category : #'EDA-Commands-Tests'
}

{ #category : #'instance creation' }
EDARegexJsonDictionary class >> newFrom: aDictionary andTestCase: aTestCase [
	| result |
	result := self withAll: aDictionary.
	result testCase: aTestCase.
	^ result
]

{ #category : #accessing }
EDARegexJsonDictionary >> assertAssociationMatches: anAssociation [
	| v entry |
	v := anAssociation value.
	(v isKindOf: Array)
		ifTrue: [ entry := self
				dictAt: anAssociation key
				for: v
				andTestCase: self testCase.
			entry
				ifNil: [ ^ v isNil ]
				ifNotNil: [ ^ (EDARegexJsonArray newFrom: entry) assertMatches: v ] ]
		ifFalse: [ (v isKindOf: Dictionary)
				ifTrue: [ entry := self dictAt: anAssociation key.
					entry
						ifNil: [ ^ v isNil ]
						ifNotNil: [ ^ (self class newFrom: entry) assertMatches: v ] ]
				ifFalse: [ | result |
					result := anAssociation key = 'id'
						ifTrue: [ true ]
						ifFalse: [ self
								string: v greaseString
								matchesRegex: (self at: anAssociation key) greaseString ].
					^ result ] ]
]

{ #category : #asserting }
EDARegexJsonDictionary >> assertMatches: aDictionary [
	| result |
	result := true.
	aDictionary associationsDo: [ :assoc | result := result and: [ self assertAssociationMatches: assoc ] ].
	^ result
]

{ #category : #'regex logic' }
EDARegexJsonDictionary >> assertString: aString matchesRegex: aRegex [
	| result |
	result := aString = aRegex.
	result := result
		ifTrue: [ self testCase assert: aString equals: aRegex ]
		ifFalse: [ | escapedRegex |
			escapedRegex := self escapeRegex: aRegex.
			self testCase assert: (aString matchesRegex: escapedRegex) ].
	^ result
]

{ #category : #accessing }
EDARegexJsonDictionary >> associationAt: key [
	| result |
	result := key = 'id'
		ifTrue: [ '(.*)' ]
		ifFalse: [ self dict associationAt: key ifAbsent: [ ^ key -> '(.*)' ] ].
	^ result
]

{ #category : #accessing }
EDARegexJsonDictionary >> dict [
	^ dict
]

{ #category : #accessing }
EDARegexJsonDictionary >> dict: aDictionary [
	dict := aDictionary
]

{ #category : #'regex logic' }
EDARegexJsonDictionary >> dictAt: key for: aValue andTestCase: aTestCase [
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ (aValue isKindOf: Array) ifTrue: [ EDARegexJsonArray newFrom: aValue andTestCase: aTestCase ] ifFalse: [ Dictionary with: '(.*)' -> '(.*)' ] ]
]

{ #category : #accessing }
EDARegexJsonDictionary >> initialize [
	self dict: Dictionary new.
]

{ #category : #asserting }
EDARegexJsonDictionary >> testCase [
	^ testCase
]

{ #category : #asserting }
EDARegexJsonDictionary >> testCase: aTestCase [
	testCase := aTestCase
]
