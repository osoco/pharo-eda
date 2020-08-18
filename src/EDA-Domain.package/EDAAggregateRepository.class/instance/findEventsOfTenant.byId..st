api
findEventsOfTenant: aTenant byId: anId
	| result criteria |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	result := self eventStore
		findEventsOfTenant: aTenant ofAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result