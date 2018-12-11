instance creation
withScanner: aCommandHandlersScanner factory: aCommandHandlerFactory
	| handlerAssocs commandClass   commandHandler registry handlerMethod |
	registry := self emptyRegistry.
	handlerAssocs := aCommandHandlersScanner allCommandHandlerMethods.
	handlerAssocs
		do: [ :assoc | 
			commandClass := assoc key.
			handlerMethod := assoc value.
			commandHandler := aCommandHandlerFactory newFromHandlerMethod: handlerMethod.
			registry registerHandler: commandHandler command: commandClass new ].
	^ registry