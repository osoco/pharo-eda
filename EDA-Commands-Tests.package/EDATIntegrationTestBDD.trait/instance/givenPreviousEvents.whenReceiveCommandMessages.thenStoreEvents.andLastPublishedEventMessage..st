bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andLastPublishedEventMessage: expectedLastEventMessage
	| frame lastFrame event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self storePreviousEvents: previousEventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	aCommandMessageCollection do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection.
	[ [ frame := self eventListener client readMessage ]
		on: Error
		do: [ frame := nil ].
	frame notNil ] whileTrue: [ lastFrame := frame ].
	self generatedEvent: lastFrame matchesRegex: expectedLastEventMessage