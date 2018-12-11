code generation
generateAttributesHashMethodFor: attributes
	| result |
	result := WriteStream with: String new.
	result
		nextPutAll: 'hash';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    ^ self class greaseString hash bitXor:( self id hash bitXor: (';
		nextPutAll: (self generateHashAndBlockRecursively: attributes);
		nextPut: $);
		nextPut: $).
	^ result contents