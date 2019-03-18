code generation
createCommandClassHashMethod
	| aggregateRootClass |
	aggregateRootClass := self class environment at: self retrieveCommandClassName asSymbol.
	^ self
		compile: 'semanticHash'
		sourceCode: (self generateHashMethodFor: self retrieveCommandAttributes)
		inClass: aggregateRootClass
		classifiedAs: self protocol