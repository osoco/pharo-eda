accessing
findEventsOfAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary
	| eventsCriteria |
	eventsCriteria := {('aggregateRootClass' -> anAggregateRootClass asString)} asDictionary.
	eventsCriteria addAll: aCriteriaDictionary.
	^ EDAEventSourcingEvent
		selectMany: eventsCriteria
		sortBy:
			{(#timestamp -> VOOrder ascending)} asDictionary