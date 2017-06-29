bdd
storePreviousEvents: eventsCollection
	Transcript
		print: 'Storing (' , eventsCollection size printString , ') events...';
		cr;
		flush.
	eventsCollection
		do: [ :event | 
			event save.
			Transcript
				print: event className , ' stored';
				cr;
				flush ].
	self application eventStore flush.
	Transcript
		cr;
		flush.
	"self waitUntilEventsArePersisted: eventsCollection."
	Transcript
		print: 'All ' , eventsCollection size printString , ' events stored';
		cr;
		flush