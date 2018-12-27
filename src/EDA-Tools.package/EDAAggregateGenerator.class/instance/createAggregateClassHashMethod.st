code generation
createAggregateClassHashMethod
	| aggregateRootClass |
	aggregateRootClass := (self class environment at: self retrieveAggregateClassName asSymbol).
	^ self
		compile: 'hash'
		sourceCode: (self generateHashMethodFor: (self allAttributesOf: aggregateRootClass including: self retrieveAggregateAttributes))
		inClass: aggregateRootClass
		classifiedAs: self protocol