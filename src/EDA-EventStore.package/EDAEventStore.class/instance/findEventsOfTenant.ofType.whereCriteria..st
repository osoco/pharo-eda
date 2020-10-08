persistence
findEventsOfTenant: aTenant ofType: anEventClass whereCriteria: aCriteria
	| criteria |
	criteria := Dictionary newFrom: aCriteria.
	criteria at: '#instanceOf' put: anEventClass greaseString.
	^ self
		findEventsOfTenant: aTenant
		ofAggregate: anEventClass aggregateRootClass
		whereCriteria: criteria