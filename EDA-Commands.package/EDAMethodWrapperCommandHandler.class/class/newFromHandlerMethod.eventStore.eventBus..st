factory
newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		handlerMethod: aMethod;
		aggregateRootClass: aMethod methodClass;
		yourself