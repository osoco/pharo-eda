tests
testHandlerNotRegistered
	| registry  aCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	self assert: (registry handlerForCommand: aCommand) equals: nil