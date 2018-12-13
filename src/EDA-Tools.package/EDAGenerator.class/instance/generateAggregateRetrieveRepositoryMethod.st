code generation - aggregate
generateAggregateRetrieveRepositoryMethod
	| result cr |
	result := WriteStream with: String new.
	cr := Character cr.
	result
		nextPutAll: self generateAggregateRetrieveRepositoryMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: self retrieveAggregateClassName;
		nextPutAll: 'Repository uniqueInstance';
		cr.
	^ result contents