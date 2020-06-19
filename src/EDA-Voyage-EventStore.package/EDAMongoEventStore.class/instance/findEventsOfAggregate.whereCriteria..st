persistence
findEventsOfAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary
	| eventsCriteria |
	eventsCriteria := (OrderedCollection
		with: 'aggregateRootClass' -> anAggregateRootClass greaseString)
		asDictionary.
	eventsCriteria addAll: aCriteriaDictionary.
	^ EDAEventSourcingEvent
		selectMany: eventsCriteria
		sortBy:
			(OrderedCollection with: #timestamp -> VOOrder ascending) asDictionary