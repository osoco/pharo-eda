persistence
findEventsOfAggregate: anAggregateRootClass whereId: aNumber
	^ self
		findEventsOfAggregate: anAggregateRootClass
		whereCriteria: (OrderedCollection with: ('id' -> aNumber)) asDictionary