code generation
generateNoAttributesEqualsMethodFor: attributes
	| result |
	result := WriteStream on: String new.
	result
		nextPutAll: '= anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ super = anInstance'.
	^ result contents