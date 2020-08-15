api
findEventsByScopeKey: anObject
	| result criteria |
	criteria := Dictionary new.
	criteria at: 'scopeKey' put: anObject.
	result := self eventStore
		findEventsOfAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result