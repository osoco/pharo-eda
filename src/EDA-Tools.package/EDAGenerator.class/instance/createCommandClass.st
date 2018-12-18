code generation - command
createCommandClass
	| cls attributes |
	cls := self retrieveCommandClassName asSymbol.
	attributes := self retrieveCommandAttributesBut: self class skippedCommandAttributes.
	(self classExists: cls)
		ifTrue: [ attributes := (self allAttributesOf: (self class environment at: cls) including: attributes) ].
	EDACommand
		subclass: self retrieveCommandClassName asSymbol
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)
