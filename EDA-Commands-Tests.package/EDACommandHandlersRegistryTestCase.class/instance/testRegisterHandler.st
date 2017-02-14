tests
testRegisterHandler
	| registry aHandler aCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	aHandler := protocol mock: 'aHandler'.
	registry registerHandler: aHandler command: aCommand.
	self assert: (registry handlerForCommand: aCommand) equals: aHandler