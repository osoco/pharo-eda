code generation
generateCommandClassRetrieveAggregateRootClassMethod
	| result cr |
		cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: (self generateCommandClassRetrieveAggregateRootClassMethodName);
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	^ ';
		nextPutAll: self retrieveAggregateClassName;
		nextPut: cr.
	^ result contents.
