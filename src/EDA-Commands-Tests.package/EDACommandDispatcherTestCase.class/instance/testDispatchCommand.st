tests
testDispatchCommand
	| aCommand aCommandHandler |
	aCommand := protocol mock: 'aCommand'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: handlersRegistry recv: #handlerForCommand:;
		with: aCommand;
		=> aCommandHandler.
	protocol describe
		once: aCommandHandler recv: #handle:withErrorStrategy:;
		with: aCommand.
	dispatcher dispatch: aCommand