code generation - aggregate
createAggregateApplyEventMethod
	^ self
		compileIfDoesNotExist: self generateApplyEventMethodName
		sourceCode: self generateApplyEventMethod
		inClass: (self appName , self aggregate capitalized) asSymbol asClass
		classifiedAs: 'reconstructing aggregate from events' asSymbol