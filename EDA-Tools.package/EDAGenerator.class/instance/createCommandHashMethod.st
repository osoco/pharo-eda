code generation - command
createCommandHashMethod
	^ self
		compile: 'hash'
		sourceCode: (self generateHashMethodFor: self retrieveCommandAttributes)
		inClass: self retrieveCommandClassName asSymbol asClass
		classifiedAs: #hash
