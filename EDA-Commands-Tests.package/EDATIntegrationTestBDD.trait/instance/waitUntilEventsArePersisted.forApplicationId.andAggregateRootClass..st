bdd
waitUntilEventsArePersisted: eventsCollection forApplicationId: appId andAggregateRootClass: aggregateRootClass
	"Waits until all events are persisted"

	| events extraEvents |
	eventsCollection
		do: [ :event | 
			(self wait: 10 until: [ ^ self isEventStored: event ] evaluatesTo: true)
				ifFalse: [ self fail: 'Event ' , event class name , ' could not be persisted' ] ].
	events :=
		self
			findAllEventsForId: appId
			andAggregateRootClass: aggregateRootClass
			inEventStore: self application eventStore.
	extraEvents := events collect: [ :e | eventsCollection anySatisfy: [ :ev | e = ev ] not ].
	(extraEvents size > 0) ifTrue: [ self fail: 'Unexpected events found in the event store. Please clean up any prior event or command' ].
	Transcript
		print: 'All events persisted. We can now go on';
		cr;
		flush