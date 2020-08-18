api
findAllEventsOfTenant: aTenant matching: aDict
	| result aggregateClass |
	aggregateClass := self aggregateClass.
	result := self eventStore
		findEventsOfTenant: aTenant ofAggregate: aggregateClass
		whereCriteria: aDict.
	result ifNil: [ result := OrderedCollection new ].
	^ result