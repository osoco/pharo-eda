code generation
generateHashAndBlockRecursively: attributes
	| result |
	attributes size > 0
		ifTrue: [ | wrap attribute |
			attribute := attributes first.
			wrap := attributes size > 1.
			wrap
				ifTrue: [ result := '(' ]
				ifFalse: [ result := '' ].
			result := result , 'self ' , attribute , ' hash'.
			attributes size > 1
				ifTrue: [ result := result , ' bitXor: ' , (self generateHashAndBlockRecursively: attributes allButFirst) ].
			wrap
				ifTrue: [ result := result , ')' ] ].
	^ result