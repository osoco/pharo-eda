code generation
createEventClassInitializeMethod
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'initialize'
		sourceCode: (self generateEventInitializeMethod)
		inClass: cls
		classifiedAs: 'initialization'