compilation
createDomainTestMethod
	^ self
		compileIfDoesNotExist: self generateDomainTestMethodName
		sourceCode: self generateDomainTestMethod
		inClass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol asClass
		classifiedAs: #BDD