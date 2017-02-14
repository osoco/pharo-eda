accessing
findEventsOfAggregate: anAggregateRootClass whereId: aNumber
	^ EDAEventSourcingEvent
		selectMany:
			{('aggregateRootClass' -> anAggregateRootClass asString).
			('id' -> aNumber)} asDictionary
		sortBy:  { (#timestamp -> VOOrder ascending) . (#'_id' -> VOOrder ascending) } asDictionary