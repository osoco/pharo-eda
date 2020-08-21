persistence
findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass
	^ self
		findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass
		whereCriteria: Dictionary new