regex logic
string: aString matchesRegex: aRegex
	| result |
	result := aString = aRegex.
	result := result
		ifTrue: [ result ]
		ifFalse: [ | escapedRegex |
			escapedRegex := self escapeRegex: aRegex.
			aString matchesRegex: escapedRegex ].
	^ result