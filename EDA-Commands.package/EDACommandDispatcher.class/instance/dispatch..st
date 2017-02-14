dispatching
dispatch: aCommand
	|   handler |
	aCommand ifNil: [ EDACommandError signal ].
	handler := self handlersRegistry handlerForCommand: aCommand.
	handler ifNil: [ EDACommandHandlerNotFound signal ].
	handler handle: aCommand withErrorStrategy: EDACommandDispatcher commandErrorHandlingStrategy