bdd
givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessage: aCommandMessage thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage
	| expectedStoredEvents aCommandMessageCollection |
	expectedStoredEvents := expectedStoredEvent
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :event | OrderedCollection with: event ].
	aCommandMessageCollection := aCommandMessage
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :message | OrderedCollection with: message ].
	self
		givenPreviousEvents: previousEventsCollection
		ofTenant: aTenant
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])