api
findEventsById: anId
	| result criteria |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	result := self eventStore findEventsOfAggregate: self aggregateClass whereCriteria: criteria.
	^ result