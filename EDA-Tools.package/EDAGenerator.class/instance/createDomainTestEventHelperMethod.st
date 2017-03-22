compilation
createDomainTestEventHelperMethod
	^ self
		compileIfDoesNotExist: self generateDomainTestEventHelperMethodName
		sourceCode: self generateDomainTestEventHelperMethod
		inClass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol asClass
		classifiedAs: #BDD