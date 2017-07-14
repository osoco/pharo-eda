code generation - aggregate
createAggregateClassAccessors
	| aggregateClass |
	aggregateClass := self class environment at: self retrieveAggregateClassName asSymbol.
	(self generateAccessorsFor: aggregateClass attributes: (self allAttributesOf: aggregateClass including: (self retrieveAggregateAttributesBut: self class skippedAggregateAttributes)))
		associationsDo: [ :assoc | 
			self
				compile: assoc key
				sourceCode: assoc value
				inClass: aggregateClass
				classifiedAs: self protocol ]