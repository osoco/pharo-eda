accessing
findEventsOfAggregate: anAggregateRootClass whereCriteria: aCriteriaDictionary
	| eventsCriteria |
	eventsCriteria := {('aggregateRootClass' -> anAggregateRootClass greaseString)}
		asDictionary.
	eventsCriteria addAll: aCriteriaDictionary.
	^ self repository
		selectMany: EDAEventSourcingEvent
		where: eventsCriteria
		sortBy: {(#timestamp -> VOOrder ascending)} asDictionary