api
findEventsOfTenant: aTenant byScopeKey: anObject
	| result criteria |
	criteria := Dictionary new.
	criteria at: 'scopeKey' put: anObject.
	result := self eventStore
		findEventsOfTenant: aTenant ofAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result