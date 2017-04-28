code generation - event
createEventClassBuilderMethod
	| methodAssoc |
	methodAssoc := self generateEventClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: (self class environment at: self retrieveEventClassName asSymbol) class
		classifiedAs: self protocol