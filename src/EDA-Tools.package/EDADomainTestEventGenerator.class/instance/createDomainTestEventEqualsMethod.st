code generation
createDomainTestEventEqualsMethod
	^ self
		compile: '='
		sourceCode: self generateDomainTestEventEqualsMethod
		inClass: (self retrieveDomainTestEventClass)
		classifiedAs: self protocol