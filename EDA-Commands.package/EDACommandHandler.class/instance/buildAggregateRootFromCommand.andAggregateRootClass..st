handling
buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass
	| result events |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	self logDebugMessage: 'Retrieving events for ' , anAggregateRootClass greaseString , ' matching ' , aCommand aggregateSelectionCriteria greaseString , '.'.
	events := eventStore findEventsOfAggregate: anAggregateRootClass whereCriteria: aCommand aggregateSelectionCriteria.
	events
		do: [ :e | 
			Transcript
				print: ' ';
				print: e class greaseString ].
	result := anAggregateRootClass new.
	self logDebugMessage: 'Applying ' , events size greaseString , ' event(s) to an empty ' , anAggregateRootClass greaseString , '.'.
	result applyEvents: events.
	result version = aCommand aggregateRootVersion
		ifFalse: [ self logWarningMessage: 'Aggregate root''s version (' , result version , ') does not match command''s (' , aCommand aggregateRootVersion , ').' ].
	^ result