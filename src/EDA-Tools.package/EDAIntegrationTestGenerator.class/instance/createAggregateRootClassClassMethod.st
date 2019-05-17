code generation
createAggregateRootClassClassMethod
	^ self
		compile: self generateAggregateRootClassMethodName
		sourceCode: self generateAggregateRootClassMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized , 'IntegrationTestCase') asSymbol) class
		classifiedAs: self protocol