code generation
createCommandClassLatestVersionClassMethod
	| cls |
	cls := self class environment
		at: self retrieveCommandClassName asSymbol.
	^ cls class 
		compile: self generateCommandClassLatestVersionMethod
		classified: self protocol