persistence
findEventsOfAggregate: anAggregateRootClass
	^ self findEventsOfAggregate: anAggregateRootClass whereCriteria: Dictionary new.