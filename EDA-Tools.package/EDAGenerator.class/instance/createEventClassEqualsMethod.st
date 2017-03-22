compilation
createEventClassEqualsMethod
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: self retrieveEventAttributes)
		inClass: self retrieveEventClassName asSymbol asClass
		classifiedAs: #equals