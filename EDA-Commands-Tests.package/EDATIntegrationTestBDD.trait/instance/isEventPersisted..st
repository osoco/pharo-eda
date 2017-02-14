as yet unclassified
isEventPersisted: event
	| events result |
	"Checks if the event is indeed persisted"
	Transcript print: 'Searching for stored events for aggregate root ', event aggregateRootClass, ' and id ', event id; cr; flush.
	events := self application eventStore findEventsOfAggregate: event aggregateRootClass whereId: event id.
	Transcript print: 'Found: ', events size printString, ' event(s).'; cr; flush.
	result := self isEvent: event inCollection: events.
	Transcript print: 'Event ', event class.
	result ifFalse: [ Transcript print: 'NOT ' ].
	Transcript print: ' found in the event store'; cr; flush.
	^ result
