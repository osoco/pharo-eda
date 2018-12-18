api
findEventById: anId type: aType andCommandId: aCommandId
	| result events criteria |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	criteria at: '#instanceOf' put: aType greaseString.
	criteria at: 'commandId' put: aCommandId.
	events := self eventStore findEventsOfAggregate: self aggregateClass whereCriteria: criteria.
	result := events ifEmpty: [ nil ] ifNotEmpty: [ :evts | evts first ].
	^ result