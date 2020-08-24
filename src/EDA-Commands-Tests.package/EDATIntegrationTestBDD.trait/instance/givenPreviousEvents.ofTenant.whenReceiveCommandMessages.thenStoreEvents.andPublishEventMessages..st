bdd
givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages
	| event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self
		storePreviousEvents: previousEventsCollection
		ofTenant: aTenant
		forApplicationId: appId
		andAggregateRootClass: rootClass.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection.
	expectedEventMessages
		do: [ :eventMessageRegex | 
			| frame |
			frame := self eventListener client readMessage.
			self generatedEvent: frame matchesRegex: eventMessageRegex ]