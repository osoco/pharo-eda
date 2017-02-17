bdd
insertPreviousEvents: eventsCollection
	Transcript print: 'Inserting (', eventsCollection size printString, ') events...'; cr; flush.
	eventsCollection do: [ :event |
		event save.
		Transcript print: event className, ' inserted'; cr; flush.
	].
	self application eventStore flush.
	Transcript cr; flush.
	"self waitUntilEventsArePersisted: eventsCollection."
	Transcript print: 'All ', eventsCollection size printString, ' events inserted'; cr; flush.
