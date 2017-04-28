code generation - domain test
createDomainTestMethod
	^ self
		compileIfDoesNotExist: self generateDomainTestMethodName
		sourceCode: self generateDomainTestMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol)
		classifiedAs: self protocol