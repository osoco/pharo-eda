api
findEventById: anId type: aType andCommandId: aCommandId
	| criteria |
	criteria := Dictionary new.
	criteria at: 'id' put: anId.
	criteria at: '#instanceOf' put: aType greaseString.
	criteria at: 'commandId' put: aCommandId.
	^ self findAllEventsMatching: criteria.
