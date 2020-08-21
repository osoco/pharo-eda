persistence
findEventsOfTenant: aTenant ofType: anEventClass
	^ self
		findEventsOfTenant: aTenant ofAggregate: anEventClass aggregateRootClass
		whereCriteria: {('#instanceOf' -> anEventClass greaseString)} asDictionary