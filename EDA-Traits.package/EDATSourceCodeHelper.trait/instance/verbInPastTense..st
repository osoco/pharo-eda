helper
verbInPastTense: aVerb
	| result |
	(aVerb matchesRegexIgnoringCase: '.*([aeiou])$')
		ifTrue: [ result := aVerb , 'd' ]
		ifFalse: [ (aVerb matchesRegexIgnoringCase: '.*t$')
				ifTrue: [ result := aVerb , 'ted' ]
				ifFalse: [ | irregular |
					irregular := self irregularPastTenses: aVerb.
					irregular ifNil: [ result := aVerb , 'ed' ] ifNotNil: [ result := irregular ] ] ].
	aVerb = aVerb asUppercase
		ifTrue: [ result := result asUppercase ].
	^ result