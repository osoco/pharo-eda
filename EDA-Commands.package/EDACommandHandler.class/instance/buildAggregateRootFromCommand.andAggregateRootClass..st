handling
buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass
	| result events |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	Transcript
		print: 'Retrieving events for ';
		print: anAggregateRootClass greaseString;
		print: ' matching ';
		print: aCommand aggregateSelectionCriteria greaseString;
		print: $.;
		cr.
	events := eventStore
		findEventsOfAggregate: anAggregateRootClass
		whereCriteria: aCommand aggregateSelectionCriteria.
	events
		do: [ :e | 
			Transcript
				print: ' ';
				print: e class greaseString ].
	result := anAggregateRootClass new.
	Transcript
		print: 'Applying ';
		print: events size greaseString;
		print: ' event(s) to an empty ';
		print: anAggregateRootClass greaseString;
		print: $.;
		cr.
	result applyEvents: events.
	result version = aCommand aggregateRootVersion
		ifFalse: [ Transcript
				print: 'WARNING: aggregate root''s version (';
				print: result version;
				print: ') does not match command''s (';
				print: aCommand aggregateRootVersion;
				print: ').';
				cr ].
	^ result