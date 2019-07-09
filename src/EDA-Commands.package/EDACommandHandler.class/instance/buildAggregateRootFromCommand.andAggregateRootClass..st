handling
buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass
	| result events startTimer |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	self logDebugMessage: 'Retrieving events for ' , anAggregateRootClass greaseString , ' matching ' , aCommand aggregateSelectionCriteria greaseString , '.'.
	events := eventStore findEventsOfAggregate: anAggregateRootClass whereCriteria: aCommand aggregateSelectionCriteria.
	result := anAggregateRootClass new.
	self logInfoMessage: 'Applying ' , events size greaseString , ' event(s) to an empty ' , anAggregateRootClass greaseString , '.'.
	startTimer := DateAndTime now.
	result applyEvents: events.
	self logInfoMessage: 'Aggregate ', result greaseString, ' successfully built in ', ((DateAndTime now - startTimer) totalSeconds) greaseString , ' second(s).'.
	result version = aCommand aggregateRootVersion
		ifFalse: [ self logWarningMessage: 'Aggregate root''s version (' , result version greaseString , ') does not match command''s (' , aCommand aggregateRootVersion greaseString , ').' ].
	^ result