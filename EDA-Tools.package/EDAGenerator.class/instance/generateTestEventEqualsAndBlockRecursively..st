code generation - test support
generateTestEventEqualsAndBlockRecursively: attributes
	| result attribute |
	attributes size > 0
		ifTrue: [ attribute := attributes first.
			result := ' (self attribute: self ' , attribute , ' matches: anInstance ' , attribute , ')'.
			attributes size > 1
				ifTrue: [ result := result , ' and: [ ' , (self generateTestEventEqualsAndBlockRecursively: attributes allButFirst) , ' ]' ] ].
	^ result