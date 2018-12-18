tests
testCreation
	| aMethod anEventStore anEventBus handler resultingEventsCollection |
	resultingEventsCollection := OrderedCollection newFrom: #('anything1' 'anything2').
	aMethod := self setUpCommandHandlerMethod: resultingEventsCollection.
	protocol describe allow: aMethod recv: #classClass; => aMethod class.
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	handler := EDAMethodWrapperCommandHandler
		newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus.
	self assert: handler isNotNil.
	self assert: handler eventStore equals: anEventStore.
	self assert: handler eventBus equals: anEventBus.	
	self assert: handler handlerMethod equals: aMethod.
	self assert: handler aggregateRootClass equals: aMethod methodClass.