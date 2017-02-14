bdd
findAllEventsForId: id andAggregateRootClass: aggregateRootClass inEventStore: eventStore
	"Retrieves all events for given aggregate root"
	| result |
	Transcript print: 'Searching for all stored events for aggregate root ', aggregateRootClass, ' and id ', id; cr; flush.
	result := eventStore findEventsOfAggregate: aggregateRootClass whereId: id.
	Transcript print: 'Found: ', result size printString, ' event(s).'; cr; flush.
	^ result