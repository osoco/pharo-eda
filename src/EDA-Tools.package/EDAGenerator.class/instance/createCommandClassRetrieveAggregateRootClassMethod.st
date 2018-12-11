code generation - command
createCommandClassRetrieveAggregateRootClassMethod
	| aggregateRootClass |
	aggregateRootClass := self class environment at: self retrieveCommandClassName asSymbol.
	^ self
		compile: (self generateCommandClassRetrieveAggregateRootClassMethodName)
		sourceCode: (self generateCommandClassRetrieveAggregateRootClassMethod)
		inClass: aggregateRootClass
		classifiedAs: self protocol