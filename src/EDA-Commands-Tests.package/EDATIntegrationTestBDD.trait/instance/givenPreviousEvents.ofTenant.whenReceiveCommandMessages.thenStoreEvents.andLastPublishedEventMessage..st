bdd
givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andLastPublishedEventMessage: expectedLastEventMessage
	| frame lastFrame event appId rootClass |
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
	[ [ frame := self eventListener client readMessage ]
		on: Error
		do: [ :err |
			self
				logErrorMessage: 'Error reading event from queue: ' , err greaseString.
			frame := nil ].
	frame notNil ] whileTrue: [ lastFrame := frame ].
	self generatedEvent: lastFrame matchesRegex: expectedLastEventMessage