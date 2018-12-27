code generation
createCommandClassEqualsMethod
	| aggregateRootClass |
	aggregateRootClass := self class environment at: self retrieveCommandClassName asSymbol.
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: self retrieveCommandAttributes)
		inClass: aggregateRootClass
		classifiedAs: self protocol