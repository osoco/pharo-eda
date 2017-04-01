code generation - event
createEventBuilderClassMethod
	| methodAssoc |
	methodAssoc := self generateEventBuilderClassMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: self retrieveEventClassName asSymbol asClass class
		classifiedAs: 'instance creation' asSymbol