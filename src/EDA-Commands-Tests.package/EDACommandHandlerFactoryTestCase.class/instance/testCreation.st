tests
testCreation
	| factory anEventStore anEventBus |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	factory := EDACommandHandlerFactory factoryWithEventStore: anEventStore eventBus: anEventBus.
	self assert: factory eventStore equals: anEventStore.
	self assert: factory eventBus equals: anEventBus.