code generation - integration test
createIntegrationTestMethod
	^ self
		compileIfDoesNotExist: self generateIntegrationTestMethodName
		sourceCode: self generateIntegrationTestMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol)
		classifiedAs: self protocol