code generation - test trait
generateTestHelperBuildEventMethod
	| result eventAttrs cr |
	cr := Character cr.
	eventAttrs := self
		retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream on: String new.
	result
		nextPutAll:
			(self
				generateTestHelperBuildEventMethodNameWithId: 'evtId'
				andCommandArg: 'inputCommandId').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result |';
		nextPut: cr.
	result
		nextPutAll: '	result := self ';
		nextPutAll: (self generateTestHelperBuildEventFromArbitraryFileMethodName);
		nextPutAll: ' self ';
		nextPutAll: self generateReadEventFromFileTestHelperMethodName;
		nextPut: $.;		
		nextPut: cr.
	result
		nextPutAll: '	result id: evtId.';
		nextPut: cr.
	result
		nextPutAll: '	result commandId: inputCommandId.';
		nextPut: cr.
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: 'Test';
		nextPutAll: (self toCamelCase: self eventName);
		nextPutAll: ' fromEvent: result';
		nextPut: cr.
	^ result contents