bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessage: aCommandMessage thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage withRoutingKey: expectedRoutingKey andPublishImageCommandMessages: expectedImageCommandMessages
	| expectedStoredEvents aCommandMessageCollection |
	expectedStoredEvents := expectedStoredEvent ifNotNil: [ OrderedCollection newFrom: {expectedStoredEvent} ].
	aCommandMessageCollection := aCommandMessage ifNotNil: [ OrderedCollection newFrom: {aCommandMessage} ].	
	self
		givenPreviousEvents: previousEventsCollection
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages: (expectedEventMessage ifNotNil: [ OrderedCollection newFrom: {expectedEventMessage} ])
		withRoutingKeys: (expectedRoutingKey ifNotNil: [OrderedCollection newFrom: {expectedRoutingKey }])
		andPublishImageCommandMessages: expectedImageCommandMessages