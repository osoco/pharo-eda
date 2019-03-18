code generation
createAggregateClassEqualsMethod
	| aggregateClassName |
	aggregateClassName := self class environment at: self retrieveAggregateClassName asSymbol.
	^ self
		compile: 'semanticEquals:'
		sourceCode: (self generateEqualsMethodFor: (self allAttributesOf: aggregateClassName including: self retrieveAggregateAttributes))
		inClass: aggregateClassName
		classifiedAs: self protocol