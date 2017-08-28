lifecycle
storePreviousEvents: eventsCollection forApplicationId: appId andAggregateRootClass: rootClass
	Transcript print: 'Storing ', eventsCollection size greaseString; print: ') event(s) ...'; cr.
	eventsCollection do: [ :event |
		event save.
		Transcript print: event className; print: ' inserted'; cr.
	].
	self application eventStore flush.
	self waitUntilEventsArePersisted: eventsCollection forApplicationId: appId andAggregateRootClass: rootClass.
	Transcript print: 'All '; print: eventsCollection size greaseString; print: ' events stored'; cr.
