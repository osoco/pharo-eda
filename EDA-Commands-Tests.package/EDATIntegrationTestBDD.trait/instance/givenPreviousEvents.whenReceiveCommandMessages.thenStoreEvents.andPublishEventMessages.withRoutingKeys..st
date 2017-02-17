as yet unclassified
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages withRoutingKeys: expectedRoutingKeys

	self insertPreviousEvents: previousEventsCollection.
	aCommandMessageCollection do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self eventMessagesMatch: expectedEventMessages withRoutingKeys: expectedRoutingKeys.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection