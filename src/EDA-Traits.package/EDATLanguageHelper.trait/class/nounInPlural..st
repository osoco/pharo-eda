helper
nounInPlural: aNoun
	| result |
	result := self irregularPluralFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*y$')
				ifTrue: [ (self removeSuffix: 'y' from: aNoun) , 'ies' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ aNoun ]
								ifFalse: [ aNoun , 's' ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result