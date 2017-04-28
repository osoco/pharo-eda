code generation
generateHashMethodFor: attributes
	| result |
	result := WriteStream with: String new.
	result nextPutAll: 'hash'; nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result nextPutAll:'	^ self id hash bitXor: ('; nextPutAll: (self generateHashAndBlockRecursively: attributes); nextPut: $).
	^ result contents