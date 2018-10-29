bdd
storePreviousEvents: eventsCollection
	self logDebugMessage: 'Storing ' , eventsCollection size greaseString , ' event(s)...'.
	eventsCollection
		do: [ :event | 
			event save.
			self logDebugMessage: event className , ' stored.'.
			self logDebugMessage: event greaseString ].
	self application eventStore flush.
	"self waitUntilEventsArePersisted: eventsCollection."
	self logDebugMessage: 'All ',eventsCollection size greaseString, ' event(s) stored'.
