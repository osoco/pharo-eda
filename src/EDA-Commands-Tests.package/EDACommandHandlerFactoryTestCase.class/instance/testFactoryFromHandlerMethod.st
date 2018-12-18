tests
testFactoryFromHandlerMethod
	| factory anEventStore anEventBus aMethod handler |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	aMethod := protocol mock: 'aMethod'.
	protocol describe allow: aMethod recv: #methodClass; => Anything class.
	factory := EDACommandHandlerFactory factoryWithEventStore: anEventStore eventBus: anEventBus.
	handler := factory newFromHandlerMethod: aMethod.
	self assert: (handler isKindOf: EDAMethodWrapperCommandHandler).
	self assert: handler eventStore equals: anEventStore.
	self assert: handler eventBus equals: anEventBus.
	self assert: handler handlerMethod equals: aMethod.