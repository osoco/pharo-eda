code generation - repository
generateRepositoryUniqueInstanceSetterClassMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateRepositoryUniqueInstanceSetterClassMethodName;
		nextPutAll: ' anInstance';
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	UniqueInstance := anInstance';
		nextPut: cr.
	^ result contents