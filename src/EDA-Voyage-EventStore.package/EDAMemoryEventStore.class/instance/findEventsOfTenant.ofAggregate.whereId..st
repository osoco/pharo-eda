persistence
findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber
	^ EDAEventSourcingEvent
		selectMany: [ :event |
			event aggregateRootClass = anAggregateRootClass asString
				and: [ event tenant = aTenant and: [ event id = aNumber ] ] ]