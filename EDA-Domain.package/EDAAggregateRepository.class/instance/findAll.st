api
findAll
	| result events aux aggregateClass |
	result := OrderedCollection new.
	aggregateClass := self aggregateClass.
	aux := Dictionary new.
	events := self eventStore findEventsOfAggregate: aggregateClass whereCriteria: Dictionary new.
	events
		do: [ :evt | 
			| list id |
			id := self aggregateIdFor: evt.
			list := aux at: id ifAbsent: [ OrderedCollection new ].
			list add: evt.
			aux at: id put: list ].
	aux
		keysAndValuesDo: [ :key :eventList | 
			| applicant |
			applicant := aggregateClass new.
			applicant applyEvents: eventList.
			result add: applicant ].
	^ result