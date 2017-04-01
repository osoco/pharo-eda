code generation - test support
createTestEventAttributeMatchesMethod
	^ self
		compileIfDoesNotExist: self generateTestEventAttributeMatchesMethodName
		sourceCode: self generateTestEventAttributeMatchesMethod
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass
		classifiedAs: 'comparison' asSymbol