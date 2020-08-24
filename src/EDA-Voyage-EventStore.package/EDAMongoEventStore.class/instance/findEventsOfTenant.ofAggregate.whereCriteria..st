persistence
findEventsOfTenant: aTenant ofAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary
	| eventsCriteria |
	eventsCriteria := (OrderedCollection
		with: ('tenant' -> aTenant greaseString)
		with: 'aggregateRootClass' -> anAggregateRootClass greaseString)
		asDictionary.
	eventsCriteria addAll: aCriteriaDictionary.
	^ EDAEventSourcingEvent
		selectMany: eventsCriteria
		sortBy: (OrderedCollection with: #timestamp -> VOOrder ascending) asDictionary