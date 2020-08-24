bdd
givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages withRoutingKeys: expectedRoutingKeys
	self storePreviousEvents: previousEventsCollection.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		assertEventMessagesMatch: expectedEventMessages
		withRoutingKeys: expectedRoutingKeys.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection