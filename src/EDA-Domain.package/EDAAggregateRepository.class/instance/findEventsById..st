api
findEventsById: anId
	| result criteria |
	anId ifNil: [ ^ #() ] 
	ifNotNil: [   
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	result := self eventStore
		findEventsOfAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result
	]