persistence
findEventsOfTenant: aTenant ofType: anEventClass whereCriteria: aCriteria
	| criteria |
	criteria := {('#instanceOf' -> anEventClass greaseString)}
		asDictionary.
	criteria addAll: aCriteria.
	^ self
		findEventsOfTenant: aTenant ofAggregate: anEventClass aggregateRootClass
		whereCriteria: criteria