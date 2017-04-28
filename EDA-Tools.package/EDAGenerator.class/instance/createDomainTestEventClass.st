code generation - domain test
createDomainTestEventClass
	| cls |
	cls := (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol.
^ (self class environment at: self retrieveEventClassName asSymbol)
				subclass: cls
				uses: EDATTestEvent
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate)