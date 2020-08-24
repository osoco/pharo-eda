persistence
findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereId: aNumber
	^ self
		findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass
		whereCriteria: (OrderedCollection with: 'id' -> aNumber) asDictionary