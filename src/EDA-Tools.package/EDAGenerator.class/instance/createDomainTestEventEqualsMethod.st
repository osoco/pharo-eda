code generation - domain test
createDomainTestEventEqualsMethod
	^ self
		compile: '='
		sourceCode: self generateDomainTestEventEqualsMethod
		inClass: (self class environment at: (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol)
		classifiedAs: self protocol