regex logic
assertString: aString matchesRegex: aRegex
	| result |
	result := aString = aRegex.
	result := result
		ifTrue: [ self testCase assert: aString equals: aRegex ]
		ifFalse: [ | escapedRegex |
			escapedRegex := self escapeRegex: aRegex.
			self testCase assert: (aString matchesRegex: escapedRegex) ].
	^ result