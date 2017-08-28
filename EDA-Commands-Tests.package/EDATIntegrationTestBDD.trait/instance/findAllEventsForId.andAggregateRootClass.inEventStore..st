lifecycle
findAllEventsForId: id andAggregateRootClass: aggregateRootClass inEventStore: eventStore
	"Retrieves all events for given aggregate root"
	| result |
	Transcript print: 'Searching for all stored events for aggregate root '; print: aggregateRootClass; print: ' and id '; print: id; cr.
	result := eventStore findEventsOfAggregate: aggregateRootClass whereId: id.
	Transcript print: 'Found: '; print: result size greaseString; print: ' event(s).'; cr.
	^ result