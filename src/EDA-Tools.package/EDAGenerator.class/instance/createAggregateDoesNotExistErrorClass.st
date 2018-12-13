code generation - errors
createAggregateDoesNotExistErrorClass
	| cls attributes |
	cls := (self appName , self aggregate capitalized , 'DoesNotExist' ) asSymbol.
	attributes := OrderedCollection new.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) ].
	^ EDAAggregateRootDoesNotExist
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)