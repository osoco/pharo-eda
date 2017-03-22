code generation
generateHashMethodFor: attributes
	| result |
	result := 'hash' , String cr.
	result := result , '    ^ self class hash bitXor: '
		, (self generateHashAndBlockRecursively: attributes).
	^ result