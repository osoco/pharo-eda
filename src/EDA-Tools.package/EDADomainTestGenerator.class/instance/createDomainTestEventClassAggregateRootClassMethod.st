code generation
createDomainTestEventClassAggregateRootClassMethod
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'aggregateRootClass'
		sourceCode: self generateEventClassAggregateRootClassMethod
		inClass: cls class
		classifiedAs: 'meta'