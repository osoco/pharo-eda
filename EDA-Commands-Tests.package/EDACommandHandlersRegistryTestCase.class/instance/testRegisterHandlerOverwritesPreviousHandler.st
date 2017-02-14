tests
testRegisterHandlerOverwritesPreviousHandler
	| registry  aCommand oldHandler newHandler |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	oldHandler := protocol mock: 'oldHandler'.
	newHandler := protocol mock: 'newHandler'.
	registry registerHandler: oldHandler command: aCommand.
	registry registerHandler: newHandler command: aCommand.
	self assert: (registry handlerForCommand: aCommand) equals: newHandler