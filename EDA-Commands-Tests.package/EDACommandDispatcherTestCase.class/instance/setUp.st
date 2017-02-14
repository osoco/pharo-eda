tests
setUp
	handlersRegistry := protocol mock: 'aCommandHandlerRegistry'.
	dispatcher := EDACommandDispatcher withRegistry: handlersRegistry.
	protocol visualize: dispatcher