lifecycle
findAllEventsForId: id andAggregateRootClass: aggregateRootClass inEventStore: eventStore
	"Retrieves all events for given aggregate root"

	| result |
	self
		logDebugMessage: 'Searching for all stored events for aggregate root ' aggregateRootClass greaseString , ' and id ' , id greaseString , '.'.
	result := eventStore findEventsOfAggregate: aggregateRootClass whereId: id.
	self logDebugMessage: 'Found: ' , result size greaseString , ' event(s).'.
	^ result