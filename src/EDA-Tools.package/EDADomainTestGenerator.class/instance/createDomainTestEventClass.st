code generation
createDomainTestEventClass
	| cls parent |
	parent :=
		self isDeleteEvent ifTrue: [
				EDADeleteCommandResultEvent
			] ifFalse: [
				self class environment at: self retrieveEventClassName asSymbol
			].
	cls := (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol.
	parent
		subclass: cls
		uses: EDATTestEvent
		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate)
