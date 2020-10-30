public-entity-creation
createEvent: aEventSourcingEventClassModel
	| event |
	event := events
		at: aEventSourcingEventClassModel
		put: (EDAFamixEvent createFromEventClass: aEventSourcingEventClassModel).
	^ event