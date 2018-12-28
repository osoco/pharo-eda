code generation
generateCommandClassAggregateRootClassMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self generateCommandClassAggregateRootClassMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: self retrieveAggregateClassName;
		nextPut: cr.
	^ result contents