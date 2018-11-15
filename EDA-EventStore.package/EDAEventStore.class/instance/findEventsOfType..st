persistence
findEventsOfType: anEventClass
	^ self findEventsOfAggregate: anEventClass aggregateRootClass whereCriteria: { '#instanceOf' -> anEventClass greaseString } asDictionary.