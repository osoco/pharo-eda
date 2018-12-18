tests
testInvokeMethodHandler
	| aCommand anEventStore anEventBus aMethod handler resultingEventsCollection aReceiver |
	resultingEventsCollection := OrderedCollection newFrom: #('anything1' 'anything2').
	aMethod := self setUpCommandHandlerMethod: resultingEventsCollection.
	aReceiver := aMethod methodClass new.
	aCommand := protocol mock: 'aCommand'.
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	handler := EDAMethodWrapperCommandHandler newFromHandlerMethod: aMethod eventStore: anEventStore eventBus: anEventBus.
	self assertCollection: (handler invokeMethodHandlerWith: aCommand on: aReceiver) equals: resultingEventsCollection