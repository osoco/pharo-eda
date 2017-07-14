bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages withRoutingKeys: expectedRoutingKeys andPublishImageCommandMessages: expectedImageCommandMessages
	| event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self storePreviousEvents: previousEventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	aCommandMessageCollection do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self assertEventMessagesMatch: expectedEventMessages withRoutingKeys: expectedRoutingKeys.
	self imageCommandMessagesMatch: expectedImageCommandMessages.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection