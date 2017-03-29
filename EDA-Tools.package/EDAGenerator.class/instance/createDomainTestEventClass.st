compilation
createDomainTestEventClass
	| cls |
	cls := (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol.
	(self containsAnyDisableRegenerationMethod: cls)
		ifFalse: [ ^ self retrieveEventClassName asClass
				subclass: cls
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate) ]