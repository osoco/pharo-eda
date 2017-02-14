factory
newFromHandlerMethod: aMethod
	^ EDAMethodWrapperCommandHandler newFromHandlerMethod: aMethod eventStore: self eventStore eventBus: self eventBus