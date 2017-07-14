bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage
	| expectedStoredEvents |
	expectedStoredEvents :=
		expectedStoredEvent
			ifNil: [ OrderedCollection new ]
			ifNotNil: [ :event | OrderedCollection with: event ].
	self
		givenPreviousEvents: previousEventsCollection
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])