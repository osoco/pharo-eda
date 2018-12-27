code generation
createDomainTestEventClass
	| cls parent parentSymbol |
	parentSymbol := self isDeleteEvent
		ifTrue: [ (self appName , (self toCamelCase: self eventName)) asSymbol ]
		ifFalse: [ self retrieveEventClassName asSymbol ].
	parent := self class environment at: parentSymbol .
	cls := (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol.
	parent
		subclass: cls
		uses: EDATTestEvent
		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate)