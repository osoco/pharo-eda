code generation
createEventClassLatestVersionClassMethod
	| cls |
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	^ self
		compile: self generateEventClassLatestVersionMethodName
		sourceCode: self generateEventClassLatestVersionMethod
		inClass: cls class
		classifiedAs: 'meta'