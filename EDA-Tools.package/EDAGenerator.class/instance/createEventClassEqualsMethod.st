code generation - event
createEventClassEqualsMethod
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: '='
		sourceCode: (self generateEqualsMethodFor: self retrieveEventAttributes)
		inClass: cls
		classifiedAs: self protocol