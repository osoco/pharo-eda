helper
verbInPresentTense: aVerb
	| result |
	result := self irregularPresentTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*ed$')
				ifTrue: [ self removeSuffix: 'd' from: aVerb ]
				ifFalse: [ self removeSuffix: 'd' from: aVerb ] ].
	result
		ifNotNil: [ :arg |
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result