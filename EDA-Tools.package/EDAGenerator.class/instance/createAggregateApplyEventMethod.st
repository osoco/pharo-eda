code generation - aggregate
createAggregateApplyEventMethod
	^ self
		compileIfDoesNotExist: self generateAggregateApplyEventMethodName
		sourceCode: self generateAggregateApplyEventMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized) asSymbol)
		classifiedAs: self protocol