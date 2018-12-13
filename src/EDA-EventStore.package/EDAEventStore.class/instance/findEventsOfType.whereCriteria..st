persistence
findEventsOfType: anEventClass whereCriteria: aCriteria
	| criteria |
	criteria := {('#instanceOf' -> anEventClass greaseString)} asDictionary.
	criteria addAll: aCriteria.
	^ self
		findEventsOfAggregate: anEventClass aggregateRootClass
		whereCriteria: criteria