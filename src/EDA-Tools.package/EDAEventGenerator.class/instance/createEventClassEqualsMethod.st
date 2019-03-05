code generation
createEventClassEqualsMethod
	| cls attributes |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	attributes := OrderedCollection withAll: self retrieveEventAttributes.
	attributes add: 'aggregateRootClass'.
	^ self
		compile: 'semanticEquals:'
		sourceCode: (self generateEqualsMethodFor: attributes)
		inClass: cls
		classifiedAs: self protocol