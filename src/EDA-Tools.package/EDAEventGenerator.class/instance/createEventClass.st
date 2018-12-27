code generation
createEventClass
	| cls attributes parent |
	cls := (self appName , (self underscoreSeparatedToCamelCase: self eventName)) asSymbol.
	attributes := self retrieveEventAttributesBut: self class skippedEventAttributes.
	(self classExists: cls)
		ifTrue: [ attributes := self allAttributesOf: (self class environment at: cls) including: attributes ].
	parent := self isDeleteEvent ifTrue: [ EDADeleteCommandResultEvent ] ifFalse: [ EDACommandResultEvent ].
	parent
		subclass: cls
		uses: ATSTEvent
		instanceVariableNames: (self concatenateCollection: attributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-' , (self toCamelCase: self aggregate)