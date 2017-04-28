code generation
generateEqualsMethodFor: attributes
	| result |
	result := WriteStream on: String new.
	result
		nextPutAll: '= anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ self class = anInstance class and: [ self id = anInstance id and: [';
		nextPutAll: (self generateEqualsAndBlockRecursively: attributes);
		nextPutAll: '] ].'.
	^ result contents