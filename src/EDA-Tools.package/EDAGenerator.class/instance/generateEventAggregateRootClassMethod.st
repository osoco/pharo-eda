code generation - event
generateEventAggregateRootClassMethod
	| result methodName cr |
	cr := Character cr.
	methodName := 'aggregateRootClass'.
	result := WriteStream with: String new.
	result nextPutAll: methodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: self aggregate;
		nextPut: cr.
	^ result contents