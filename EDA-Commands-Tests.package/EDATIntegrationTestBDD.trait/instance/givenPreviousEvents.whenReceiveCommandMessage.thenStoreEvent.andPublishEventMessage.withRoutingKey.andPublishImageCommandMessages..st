bdd
givenPreviousEvents: previousEventsCollection whenReceiveCommandMessage: aCommandMessage thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage withRoutingKey: expectedRoutingKey andPublishImageCommandMessages: expectedImageCommandMessages
	| expectedStoredEvents aCommandMessageCollection |
	expectedStoredEvents :=
		expectedStoredEvent
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :event | OrderedCollection with: event ].
	aCommandMessageCollection :=
		aCommandMessage
			ifNil: [ OrderedCollection new ]
			ifNotNil: [ :message | OrderedCollection with: message ].
	self
		givenPreviousEvents: previousEventsCollection
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])
		withRoutingKeys:
			(expectedRoutingKey
				ifNil: [ nil ]
				ifNotNil: [ :routingKey | OrderedCollection with: routingKey ])
		andPublishImageCommandMessages: expectedImageCommandMessages