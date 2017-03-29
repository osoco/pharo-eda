compilation
createDomainTestEventAttributeMatchesMethod
	^ self
		compileIfDoesNotExist: self generateDomainTestEventAttributeMatchesMethodName
		sourceCode: self generateDomainTestEventAttributeMatchesMethod
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass
		classifiedAs: 'comparison' asSymbol