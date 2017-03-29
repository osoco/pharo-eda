compilation
createDomainTestEventEqualsMethod
	^ self
		compileIfDoesNotExist: '='
		sourceCode: self generateDomainTestEventEqualsMethod
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass
		classifiedAs: 'equals' asSymbol