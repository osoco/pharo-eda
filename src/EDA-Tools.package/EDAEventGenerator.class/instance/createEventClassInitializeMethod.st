code generation
createEventClassInitializeMethod
	| cls |
	cls := self class environment
		at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'initialize'
		sourceCode: self generateEventInitializeMethod
		inClass: cls class
		classifiedAs: 'initialization'