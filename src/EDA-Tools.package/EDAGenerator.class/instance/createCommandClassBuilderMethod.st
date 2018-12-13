code generation - command
createCommandClassBuilderMethod
	| methodAssoc |
	methodAssoc := self generateCommandClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: (self class environment at: self retrieveCommandClassName asSymbol) class
		classifiedAs: self protocol