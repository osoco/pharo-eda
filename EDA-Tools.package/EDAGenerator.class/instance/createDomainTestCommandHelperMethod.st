compilation
createDomainTestCommandHelperMethod
	^ self
		compileIfDoesNotExist: self generateDomainTestCommandHelperMethodName
		sourceCode: self generateDomainTestCommandHelperMethod
		inClass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol asClass
		classifiedAs: #BDD