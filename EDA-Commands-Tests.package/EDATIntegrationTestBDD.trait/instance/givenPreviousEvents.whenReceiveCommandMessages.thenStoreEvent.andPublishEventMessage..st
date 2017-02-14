bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage
	| expectedStoredEvents |
	expectedStoredEvents := expectedStoredEvent ifNotNil: [ OrderedCollection newFrom: {expectedStoredEvent} ].
	self
		givenPreviousEvents: previousEventsCollection
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages: (expectedEventMessage ifNotNil: [ OrderedCollection newFrom: {expectedEventMessage} ]).