code generation
generateRepositoryUniqueInstanceGetterClassMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateRepositoryUniqueInstanceGetterClassMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result |';
		nextPut: cr.
	result
		nextPutAll: '	result := UniqueInstance.';
		nextPut: cr.
	result
		nextPutAll: '	result';
		nextPut: cr.
	result
		nextPutAll: '		ifNil: [ result := self new.';
		nextPut: cr.
	result
		nextPutAll: '			result eventStore: EventStore.';
		nextPut: cr.
	result
		nextPutAll: '			self ';
		nextPutAll: self generateRepositoryUniqueInstanceSetterClassMethodName;
		nextPutAll: ' result ].';
		nextPut: cr.
	result nextPutAll: '	^ result'; nextPut: cr.
	^ result contents