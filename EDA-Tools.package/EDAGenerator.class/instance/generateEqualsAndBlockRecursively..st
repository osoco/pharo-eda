code generation
generateEqualsAndBlockRecursively: attributes
	| result attribute |
	attributes size > 0
		ifTrue: [ attribute := attributes first.
			result := ' self ' , attribute , ' = anInstance ' , attribute.
			attributes size > 1
				ifTrue: [ result := result , ' and: [ ' , (self generateEqualsAndBlockRecursively: attributes allButFirst) , ' ]' ] ].
	^ result