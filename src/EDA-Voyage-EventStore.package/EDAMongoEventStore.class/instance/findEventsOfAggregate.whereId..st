accessing
findEventsOfAggregate: anAggregateRootClass whereId: aNumber
	^ self findEventsOfAggregate: anAggregateRootClass whereCriteria: { ('id' -> aNumber) } asDictionary.