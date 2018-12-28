code generation
createCommandClassAggregateRootClassMethod
	| aggregateRootClass |
	aggregateRootClass := self class environment at: self retrieveCommandClassName asSymbol.
	^ self
		compile: self generateCommandClassAggregateRootClassMethodName
		sourceCode: self generateCommandClassAggregateRootClassMethod
		inClass: aggregateRootClass class
		classifiedAs: self protocol