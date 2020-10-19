api
findEventsOfTenant: aTenant byScopeKey: anObject
	| result criteria |
	criteria := Dictionary new.
	anObject ifNotNil: [ :aKey |
	criteria at: 'scopeKey' put: aKey ].
	result := self eventStore
		findEventsOfTenant: aTenant
		ofAggregate: self aggregateClass
		whereCriteria: criteria.
	^ result