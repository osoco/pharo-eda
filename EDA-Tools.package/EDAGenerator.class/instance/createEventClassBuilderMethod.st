compilation
createEventClassBuilderMethod
	| methodAssoc |
	methodAssoc := self generateEventClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: self retrieveEventClassName asSymbol asClass class
		classifiedAs: 'instance creation' asSymbol