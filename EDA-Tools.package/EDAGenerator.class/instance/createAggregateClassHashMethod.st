compilation
createAggregateClassHashMethod
	^ self compile: 'hash' sourceCode: (self generateHashMethodFor: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes)) inClass: (self retrieveAggregateClassName asSymbol asClass) classifiedAs: #hash