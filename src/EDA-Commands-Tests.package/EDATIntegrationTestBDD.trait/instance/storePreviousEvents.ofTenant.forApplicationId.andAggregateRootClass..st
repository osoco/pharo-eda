lifecycle
storePreviousEvents: eventsCollection ofTenant: aTenant forApplicationId: appId andAggregateRootClass: rootClass
	self
		logDebugMessage: 'Storing ' , eventsCollection size greaseString , ') event(s) ...'.
	eventsCollection
		do: [ :event | 
			event save.
			self logDebugMessage: event className greaseString , ' inserted.' ].
	self application eventStore flush.
	self
		waitUntilEventsArePersisted: eventsCollection
		ofTenant: aTenant forApplicationId: appId
		andAggregateRootClass: rootClass.
	self
		logDebugMessage: 'All ' , eventsCollection size greaseString , ' events stored.'