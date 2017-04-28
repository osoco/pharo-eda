code generation - domain test
createDomainTestEventEqualsMethod
	^ self
		compileIfDoesNotExist: '='
		sourceCode: self generateDomainTestEventEqualsMethod
		inClass: (self class environment at: (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol)
		classifiedAs: self protocol