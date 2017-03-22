compilation
createIntegrationTestMethod
	^ self
		compileIfDoesNotExist: self generateIntegrationTestMethodName
		sourceCode: self generateIntegrationTestMethod
		inClass: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol asClass
		classifiedAs: #tests