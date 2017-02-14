tests
testRegistryUseCommandClass
	| registry aHandler aCommand anotherCommand |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aCommand := protocol mock: 'aCommand'.
	anotherCommand := protocol mock: 'anotherCommand'.
	aHandler := protocol mock: 'aHandler'.
	registry registerHandler: aHandler command: aCommand.
	self assert: (registry handlerForCommand: anotherCommand) equals: aHandler