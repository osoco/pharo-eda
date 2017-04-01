code generation - command
createCommand
	| cls |
	cls := self retrieveCommandClassName asSymbol.
	(self containsAnyDisableRegenerationMethod: cls)
		ifFalse: [ ^ EDACommand
				subclass: self retrieveCommandClassName asSymbol
				instanceVariableNames: (self concatenateCollection: (self retrieveCommandAttributesBut: EDAGenerator skippedCommandAttributes) with: ' ')
				classVariableNames: ''
				package: (self appName) , '-Domain-' , (self toCamelCase: self aggregate) ]