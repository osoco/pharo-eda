code generation - test support
createTestEventEqualsMethod
	^ self
		compileIfDoesNotExist: '='
		sourceCode: self generateTestEventEqualsMethod
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass
		classifiedAs: 'equals' asSymbol