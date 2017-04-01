code generation - event
createEventEqualsMethod
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: self retrieveEventAttributes)
		inClass: self retrieveEventClassName asSymbol asClass
		classifiedAs: #equals