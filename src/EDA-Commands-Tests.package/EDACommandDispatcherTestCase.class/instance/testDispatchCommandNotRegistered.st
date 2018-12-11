tests
testDispatchCommandNotRegistered
	| aCommand aCommandHandler |
	aCommand := protocol mock: 'aCommand'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: handlersRegistry recv: #handlerForCommand:;
		with: aCommand;
		=> nil.
	self should: [ dispatcher dispatch: aCommand ] raise: EDACommandHandlerNotFound