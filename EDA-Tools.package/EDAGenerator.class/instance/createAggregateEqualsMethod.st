code generation - aggregate
createAggregateEqualsMethod
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes ))
		inClass: self retrieveAggregateClassName asSymbol asClass
		classifiedAs: #equals