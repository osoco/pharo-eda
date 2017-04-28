code generation - command
createCommandClassEqualsMethod
	| aggregateRootClass |
	aggregateRootClass := (self class environment at: self retrieveCommandClassName asSymbol).
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: (self allAttributesOf: aggregateRootClass including: self retrieveCommandAttributes))
		inClass: aggregateRootClass
		classifiedAs: self protocol