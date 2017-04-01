code generation - aggregate
createAggregateAccessors
	| aggregateClass |
	aggregateClass := self retrieveAggregateClassName asSymbol.
	(self generateAccessorsFor: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes))
		associationsDo: [ :assoc |
			self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: aggregateClass asClass
				classifiedAs: #accessing ]