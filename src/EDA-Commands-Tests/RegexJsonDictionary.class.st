Class {
	#name : #RegexJsonDictionary,
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
RegexJsonDictionary class >> newFrom: aDictionary andTestCase: aTestCase [
	| result |
	result := self withAll: aDictionary.
	result testCase: aTestCase.
	^ result
]

{ #category : #accessing }
RegexJsonDictionary >> assertAssociationMatches: anAssociation [
	| v entry |
	v := anAssociation value.
	(v isKindOf: Array)
		ifTrue: [ entry := self
				dictAt: anAssociation key
				for: v
				andTestCase: self testCase.
			entry
				ifNil: [ ^ v isNil ]
				ifNotNil: [ ^ (RegexJsonArray newFrom: entry) assertMatches: v ] ]
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
RegexJsonDictionary >> assertMatches: aDictionary [
	| result |
	result := true.
	aDictionary associationsDo: [ :assoc | result := result and: [ self assertAssociationMatches: assoc ] ].
	^ result
]

{ #category : #'regex logic' }
RegexJsonDictionary >> assertString: aString matchesRegex: aRegex [
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
RegexJsonDictionary >> associationAt: key [
	| result |
	result := key = 'id'
		ifTrue: [ '(.*)' ]
		ifFalse: [ self dict associationAt: key ifAbsent: [ ^ key -> '(.*)' ] ].
	^ result
]

{ #category : #accessing }
RegexJsonDictionary >> dict [
	^ dict
]

{ #category : #accessing }
RegexJsonDictionary >> dict: aDictionary [
	dict := aDictionary
]

{ #category : #'regex logic' }
RegexJsonDictionary >> dictAt: key for: aValue andTestCase: aTestCase [
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ (aValue isKindOf: Array) ifTrue: [ RegexJsonArray newFrom: aValue andTestCase: aTestCase ] ifFalse: [ Dictionary with: '(.*)' -> '(.*)' ] ]
]

{ #category : #accessing }
RegexJsonDictionary >> initialize [
	self dict: Dictionary new.
]

{ #category : #asserting }
RegexJsonDictionary >> testCase [
	^ testCase
]

{ #category : #asserting }
RegexJsonDictionary >> testCase: aTestCase [
	testCase := aTestCase
]
