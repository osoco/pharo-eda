as yet unclassified
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages withRoutingKeys: expectedRoutingKeys
	| event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self insertPreviousEvents: previousEventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	aCommandMessageCollection do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self eventMessagesMatch: expectedEventMessages withRoutingKeys: expectedRoutingKeys.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection