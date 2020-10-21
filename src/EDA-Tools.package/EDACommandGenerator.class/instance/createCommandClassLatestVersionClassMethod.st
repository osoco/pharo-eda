code generation
createCommandClassLatestVersionClassMethod
	| cls |
	cls := self class environment
		at: self retrieveCommandClassName asSymbol.
	^ self
		compile: self generateCommandClassLatestVersionMethodName
		sourceCode: self generateCommandClassLatestVersionMethod
		inClass: cls class
		classifiedAs: 'meta'