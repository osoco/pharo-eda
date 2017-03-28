helper
verbInPastTense: aVerb
	| result |
	result := self irregularPastTenses: aVerb.
	result ifNil: [
		(aVerb matchesRegexIgnoringCase: '.*([aeiou])$')
			ifTrue: [ result := aVerb , 'd' ]
			ifFalse: [ result := aVerb , 'ed' ] ].
	result ifNotNil: [ aVerb = aVerb asUppercase ifTrue: [ result := result asUppercase ] ].
	^ result
