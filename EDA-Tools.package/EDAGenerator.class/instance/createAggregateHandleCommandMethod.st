code generation - aggregate
createAggregateHandleCommandMethod
	^ self
		compileIfDoesNotExist: self generateAggregateHandleCommandMethodName
		sourceCode: self generateAggregateHandleCommandMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized) asSymbol)
		classifiedAs: self protocol