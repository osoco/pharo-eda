code generation
generateTestHelperBuildDeleteEventMethod
	| result eventAttrs cr |
	cr := Character cr.
	eventAttrs := self retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream on: String new.
	result nextPutAll: (self generateTestHelperBuildDeleteEventMethodNameWithId: 'evtId' andCommandArg: 'aCommand').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result |';
		nextPut: cr.
	result
		nextPutAll: '	result := ';
		nextPutAll: self appName;
		nextPutAll: 'Test';
		nextPutAll: (self toCamelCase: self eventName);
		nextPutAll: ' new.';
		nextPut: cr.
	result
		nextPutAll: '	result id: aCommand aggregateRootId.';
		nextPut: cr.
	result
		nextPutAll: '	result version: aCommand version.';
		nextPut: cr.
	result
		nextPutAll: '	result aggregateRootVersion: aCommand aggregateRootVersion + 1.';
		nextPut: cr.
	result
		nextPutAll: '	result timestamp: ''<ANYTHING>''.';
		nextPut: cr.
	result
		nextPutAll: '	result commandId: aCommand commandId.';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
		nextPut: cr.
	^ result contents