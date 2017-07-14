code generation - errors
createInvalidAggregateErrorClass
	| cls attributes |
	cls := (self appName , 'Invalid' , self aggregate capitalized ) asSymbol.
	attributes := OrderedCollection new.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) ].
	^ Error
		subclass: cls
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)