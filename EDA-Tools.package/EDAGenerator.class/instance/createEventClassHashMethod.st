code generation - event
createEventClassHashMethod
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'hash'
		sourceCode: (self generateHashMethodFor: self retrieveEventAttributes)
		inClass: cls
		classifiedAs: self protocol