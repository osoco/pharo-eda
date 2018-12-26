code generation - event
createEventClassAggregateRootClassMethod
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'aggregateRootClass'
		sourceCode: self generateAggregateRootClassMethod
		inClass: cls
		classifiedAs: 'meta'