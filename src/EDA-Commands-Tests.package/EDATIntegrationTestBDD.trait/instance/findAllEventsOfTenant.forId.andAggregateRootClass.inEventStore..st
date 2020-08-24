lifecycle
findAllEventsOfTenant: aTenant forId: id andAggregateRootClass: aggregateRootClass inEventStore: eventStore
	"Retrieves all events for given aggregate root"

	| result |
	self
		logDebugMessage:
			'Searching for all stored events of ' , aTenant , ' for aggregate root '
				aggregateRootClass greaseString , ' and id ' , id greaseString
				, '.'.
	result := eventStore
		findEventsOfTenant: aTenant ofAggregate: aggregateRootClass
		whereId: id.
	self
		logDebugMessage: 'Found: ' , result size greaseString , ' event(s).'.
	^ result