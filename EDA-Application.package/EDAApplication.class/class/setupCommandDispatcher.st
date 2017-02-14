initialization
setupCommandDispatcher
	| handlerScanner  handlerFactory commandRegistry |
	handlerScanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #useAsCommandHandlerFor: from: EDAAggregateRoot.
	handlerFactory := EDACommandHandlerFactory factoryWithEventStore: self eventStore eventBus: self eventProducer.
	commandRegistry := EDACommandHandlersRegistry withScanner: handlerScanner factory: handlerFactory.
	self commandDispatcher: (EDACommandDispatcher withRegistry: commandRegistry).