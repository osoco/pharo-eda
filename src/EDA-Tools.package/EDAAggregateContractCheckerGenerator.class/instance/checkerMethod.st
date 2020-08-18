code generation
checkerMethod
	| result cr |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: self checkerMethodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	self assert: ((';
		nextPutAll: self retrieveAggregateClassName;
		nextPutAll:
			' thoroughWhichSelectorsReferTo: #ofTenant:withAggregateId:commandId:andAttributes:) select: [ :methodName | methodName = ''handle';
		nextPutAll: (self underscoreSeparatedToCamelCase: commandName);
		nextPutAll: ':'']) isNotEmpty.';
		nextPut: cr.
	^ result contents