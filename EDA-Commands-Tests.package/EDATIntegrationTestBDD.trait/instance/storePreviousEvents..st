as yet unclassified
storePreviousEvents: eventsCollection
	Transcript
		print: 'Storing ' ; print: eventsCollection size greaseString; print: ' event(s)...';
		cr.
	eventsCollection
		do: [ :event | 
			event save.
			Transcript
				print: event className;
				print: ' stored.';
				cr;
				print: event greaseString;
				cr ].
	self application eventStore flush.
	"self waitUntilEventsArePersisted: eventsCollection."
	Transcript
		print: 'All ';
		print: eventsCollection size greaseString;
		print: ' event(s) stored';
		cr