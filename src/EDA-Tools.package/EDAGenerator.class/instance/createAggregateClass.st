code generation - aggregate
createAggregateClass
	| cls attributes |
	cls := self aggregateClass asSymbol.
	attributes := self retrieveAggregateAttributesBut: self class skippedAggregateAttributes.
		(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) including: attributes ].

	^ EDAAggregateRoot
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)