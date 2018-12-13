code generation - domain test
generateDomainTestEventEqualsAndBlockRecursively: attributes
	| result attribute |
	attributes size > 0
		ifTrue: [ attribute := attributes first.
			result := ' (self attribute: self ' , attribute , ' named: ''' , attribute , ''' matches: anInstance ' , attribute , ')'.
			attributes size > 1
				ifTrue: [ result := result , ' and: [ ' , (self generateDomainTestEventEqualsAndBlockRecursively: attributes allButFirst) , ' ]' ] ].
	^ result