code generation
createAggregateClassEqualsMethod
	| aggregateClassName |
	aggregateClassName := (self class environment at: self retrieveAggregateClassName asSymbol).
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: (self allAttributesOf: aggregateClassName including: self retrieveAggregateAttributes))
		inClass: aggregateClassName
		classifiedAs: self protocol