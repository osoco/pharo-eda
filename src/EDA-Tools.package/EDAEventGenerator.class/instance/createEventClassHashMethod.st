code generation
createEventClassHashMethod
	| cls attributes |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	attributes := (OrderedCollection withAll: self retrieveEventAttributes).
	attributes add: 'aggregateRootClass'.
	^ self
		compile: 'hash'
		sourceCode: (self generateHashMethodFor: attributes)
		inClass: cls
		classifiedAs: self protocol