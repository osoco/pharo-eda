Trait {
	#name : #EDATJsonRegexHelper,
	#category : 'EDA-Commands-Tests'
}

{ #category : #'regex logic' }
EDATJsonRegexHelper >> assertString: aString matchesRegex: aRegex [
	| result |
	result := aString = aRegex.
	result := result
		ifTrue: [ self testCase assert: aString equals: aRegex ]
		ifFalse: [ | escapedRegex |
			escapedRegex := self escapeRegex: aRegex.
			self testCase assert: (aString matchesRegex: escapedRegex) ].
	^ result
]

{ #category : #'regex logic' }
EDATJsonRegexHelper >> at: key [
	^ self at: key ifAbsent: [ ^ key -> '(.*)' ]
]

{ #category : #'regex logic' }
EDATJsonRegexHelper >> dictAt: key [
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ Dictionary with: '(.*)' -> '(.*)' ]
]

{ #category : #'regex logic' }
EDATJsonRegexHelper >> dictAt: key for: aValue andTestCase: aTestCase [
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ (aValue isKindOf: Array) ifTrue: [ EDARegexJsonArray newFrom: aValue andTestCase: aTestCase ] ifFalse: [ Dictionary with: '(.*)' -> '(.*)' ] ]
]

{ #category : #'regex logic' }
EDATJsonRegexHelper >> escapeRegex: aRegex [
	| result |
	result := aRegex copyWithRegex: '<ANYTHING>' matchesReplacedWith: '(.*)'.
	result := result copyWithRegex: '1970-01-01T00\:00\:00' matchesReplacedWith: '(.*)'.
	result := result copyWithRegex: '\:' matchesReplacedWith: '\:'.
	^ result
]

{ #category : #'regex logic' }
EDATJsonRegexHelper >> string: aString matchesRegex: aRegex [
	| result |
	result := aString = aRegex.
	result := result
		ifTrue: [ result ]
		ifFalse: [ | escapedRegex |
			escapedRegex := self escapeRegex: aRegex.
			aString matchesRegex: escapedRegex ].
	^ result
]
