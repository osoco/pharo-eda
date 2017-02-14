as yet unclassified
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andLastPublishedEventMessage: expectedLastEventMessage withRoutingKey: expectedRoutingKey
	| frame lastFrame appId rootClass |
	self insertPreviousEvents: previousEventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection.
	[
	  [ frame := self imageListener client readMessage ]
		  on: Error
		  do: [ frame := nil ].
	  frame notNil ] whileTrue: [ lastFrame := frame ].
	self generatedEvent: lastFrame matchesRegex: expectedLastEventMessage.
	self assert: (self routingKeyFromDestination: lastFrame destination) equals: expectedRoutingKey.