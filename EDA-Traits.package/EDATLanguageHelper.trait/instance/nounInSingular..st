helper
nounInSingular: aNoun
	| result |
	result := self irregularSingularFormFor: aNoun.
	result
		ifNil: [ result := (aNoun matchesRegexIgnoringCase: '.*ies$')
				ifTrue: [ (self removeSuffix: 'ies' from: aNoun) , 'y' ]
				ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*es$')
						ifTrue: [ self removeSuffix: 's' from: aNoun ]
						ifFalse: [ (aNoun matchesRegexIgnoringCase: '.*s$')
								ifTrue: [ self removeSuffix: 's' from: aNoun ]
								ifFalse: [ aNoun ] ] ] ].
	result
		ifNotNil: [ :arg | 
			aNoun = aNoun asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result