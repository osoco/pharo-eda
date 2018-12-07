accessing
findEventsOfAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary
	| eventsCriteria |
	eventsCriteria := {('aggregateRootClass' -> anAggregateRootClass greaseString)} asDictionary.
	eventsCriteria addAll: aCriteriaDictionary.
	^ EDAEventSourcingEvent
		selectMany: eventsCriteria
		sortBy:
			{(#timestamp -> VOOrder ascending)} asDictionary