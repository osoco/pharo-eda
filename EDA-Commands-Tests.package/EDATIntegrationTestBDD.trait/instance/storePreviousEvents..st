<<<<<<< HEAD
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
=======
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
>>>>>>> BATS-321: Some refactoring to be able to perform assets at the lower level possible.
