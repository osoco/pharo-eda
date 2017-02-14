persistence
findEventsOfAggregate: anAggregateRootClass whereId: aNumber
	^ EDAEventSourcingEvent
		selectMany: [ :event | event aggregateRootClass = anAggregateRootClass asString and: [ event id = aNumber ] ]