code generation - aggregate
createAggregateApplyEventVersionMethod
	^ self
		compile: self generateAggregateApplyEventVersionMethodName
		sourceCode: self generateAggregateApplyEventVersionMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized) asSymbol)
		classifiedAs: self protocol