code generation
createEventClassLatestVersionClassMethod
	| cls |
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	cls class
		compile: self generateEventClassLatestVersionMethod
		classified: self protocol