compilation
createEventClass
	| cls |
	cls := (self appName , (self toCamelCase: self retrieveEventName)) asSymbol.
	(self containsAnyDisableRegenerationMethod: cls) ifFalse: [
	^ EDACommandResultEvent
		subclass: cls
		uses: ATSTEvent
		instanceVariableNames: (self concatenateCollection: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes) with: ' ')
		classVariableNames: ''
		package: (self appName) , '-Domain-', (self toCamelCase: self aggregate) ]