testing
isEventStored: event
	| events result message |
	"Checks if the event is indeed persisted"
	self
		logDebugMessage:
			'Searching for stored events for aggregate root '
				, event aggregateRootClass greaseString , ' and id '
				, event id greaseString , '.'.
	events := self application eventStore
		findEventsOfTenant: event tenant ofAggregate: event aggregateRootClass
		whereId: event id.
	self
		logDebugMessage: 'Found ' , events size greaseString , ' event(s).'.
	result := self isEvent: event inCollection: events.
	message := 'Event ' , event class greaseString.
	result
		ifFalse: [ message := message , 'NOT ' ].
	message := message , ' found in the event store'.
	self logDebugMessage: message.
	^ result