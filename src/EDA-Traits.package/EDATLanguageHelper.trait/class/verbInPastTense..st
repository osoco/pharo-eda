helper
verbInPastTense: aVerb
	| result |
	result := self irregularPastTenses: aVerb.
	result
		ifNil: [ result := (aVerb matchesRegexIgnoringCase: '.*([aeiou])$')
				ifTrue: [ aVerb , 'd' ]
				ifFalse: [ aVerb , 'ed' ] ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result