code generation - event
createEventClass
	| cls attributes |
	cls := (self appName , (self underscoreSeparatedToCamelCase: self eventName)) asSymbol.
	attributes := self retrieveEventAttributesBut: self class skippedEventAttributes.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls)  including: attributes ].
	^ EDACommandResultEvent
		subclass: cls
		uses: ATSTEvent
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)