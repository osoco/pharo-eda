initialization
setupCommandDispatcher
	| handlerScanner  handlerFactory commandRegistry |
	EDADeleteCommandHandler eventStore: self eventStore; eventBus: self eventProducer.
	handlerScanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #useAsCommandHandlerFor: from: EDAAggregateRoot.
	handlerFactory := EDACommandHandlerFactory factoryWithEventStore: self eventStore eventBus: self eventProducer.
	commandRegistry := EDACommandHandlersRegistry withScanner: handlerScanner factory: handlerFactory.
	self commandDispatcher: (EDACommandDispatcher withRegistry: commandRegistry).