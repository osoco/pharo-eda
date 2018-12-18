code generation
generateNoAttributesHashMethodFor: attributes
	| result |
	result := WriteStream with: String new.
	result
		nextPutAll: 'hash';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    ^ super hash'.
	^ result contents