as yet unclassified
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages
	| event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self insertPreviousEvents: previousEventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	aCommandMessageCollection do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection.
	expectedEventMessages
		do: [ :eventMessageRegex |
			| frame |
			frame := self eventListener client readMessage.
			self generatedEvent: frame matchesRegex: eventMessageRegex ]