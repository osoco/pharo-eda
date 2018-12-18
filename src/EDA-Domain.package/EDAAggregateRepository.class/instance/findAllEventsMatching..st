api
findAllEventsMatching: aDict
	| result aggregateClass |
	aggregateClass := self aggregateClass.
	result := self eventStore findEventsOfAggregate: aggregateClass whereCriteria: aDict.
	result ifNil: [ result := OrderedCollection new ].
	^ result