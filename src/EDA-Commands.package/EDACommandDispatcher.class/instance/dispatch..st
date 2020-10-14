dispatching
dispatch: aCommand
	| handler |
	aCommand ifNil: [ EDACommandError signal ].
	handler := aCommand isDelete
		ifTrue: [ EDADeleteCommandHandler uniqueInstance ]
		ifFalse: [ self handlersRegistry handlerForCommand: aCommand ].
	handler ifNil: [ EDACommandHandlerNotFound signal ].
	handler
		handle: aCommand
		withErrorStrategy: EDACommandDispatchingErrorBehavior strategy