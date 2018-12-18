factory
factoryWithEventStore: anEventStore eventBus: anEventBus
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		yourself