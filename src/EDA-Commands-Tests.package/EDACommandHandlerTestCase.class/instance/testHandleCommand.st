tests
testHandleCommand
	| anEventStore anEventBus handler aCommand anAggregateRootClass aCommandHandlerClass producedEventsCollection previousEventsCollection aggRootId aggregateRootVersion tenant |
	anEventStore := protocol mock: 'anEventStore'.
	anEventBus := protocol mock: 'anEventBus'.
	aCommand := protocol mock: 'aCommand'.
	tenant := 'tenant'.
	aggRootId := 103.
	aggregateRootVersion := 1.
	producedEventsCollection := OrderedCollection newFrom: #(4 5 6 7).
	aCommandHandlerClass := self
		setUpCommandHandlerSubclassMock: producedEventsCollection.
	anAggregateRootClass := self setUpAggregateRootClassMock.
	previousEventsCollection := OrderedCollection newFrom: #(1 2 3).
	protocol describe
		allow: aCommand recv: #tenant;
		=> tenant.
	protocol describe
		allow: aCommand recv: #aggregateRootId;
		=> aggRootId.
	protocol describe
		allow: aCommand recv: #aggregateRootVersion;
		=> aggregateRootVersion.
	protocol describe
		once: anEventStore recv: #findEventsOfTenant:ofAggregate:whereId:;
		with: tenant and: anAggregateRootClass and: aggRootId;
		=> previousEventsCollection.
	protocol describe
		once: anEventStore recv: #saveEvents:onAggregate:;
		with: producedEventsCollection
			and: [ :aggregateRoot | aggregateRoot isKindOf: anAggregateRootClass ].
	protocol describe
		once: anEventBus recv: #produceEvents:;
		with: producedEventsCollection.
	handler := aCommandHandlerClass new
		eventStore: anEventStore;
		eventBus: anEventBus.
	protocol visualize: handler.
	handler aggregateRootClass: anAggregateRootClass.
	handler
		handle: aCommand
		withErrorStrategy: EDADebugErrorStrategy asString.
	self
		assertCollection: anAggregateRootClass appliedEvents
		equals: previousEventsCollection.
	self assert: handler invokedCommand equals: aCommand.
	self assert: (handler invokedReceiver isKindOf: anAggregateRootClass)