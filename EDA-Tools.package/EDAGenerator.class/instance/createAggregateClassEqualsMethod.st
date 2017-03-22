compilation
createAggregateClassEqualsMethod
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes ))
		inClass: self retrieveAggregateClassName asSymbol asClass
		classifiedAs: #equals