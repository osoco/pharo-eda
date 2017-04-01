code generation - command
createCommandClassBuilderMethod
	| methodAssoc |
	methodAssoc := self generateCommandClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: self retrieveCommandClassName asSymbol asClass class
		classifiedAs: 'instance creation' asSymbol