compilation
createAggregateClass
	| cls |
	cls := self retrieveAggregateClassName.
	(self containsAnyDisableRegenerationMethod: cls) ifFalse: [ 
	^ EDAAggregateRoot
		subclass: cls
		instanceVariableNames: (self concatenateCollection: self retrieveEventAttributes with: ' ')
		classVariableNames: ''
		package: self appName , '-Domain-', (self toCamelCase: self aggregate) ]