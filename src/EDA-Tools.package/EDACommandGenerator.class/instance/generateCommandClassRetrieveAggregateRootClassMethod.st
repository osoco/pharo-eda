code generation
generateCommandClassRetrieveAggregateRootClassMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateCommandClassRetrieveAggregateRootClassMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ self class ';
		nextPutAll: self generateCommandClassAggregateRootClassMethodName;
		nextPut: cr.
	^ result contents