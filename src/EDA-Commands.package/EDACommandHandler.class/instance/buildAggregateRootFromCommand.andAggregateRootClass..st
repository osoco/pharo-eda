handling
buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass
	| result events startRetrievingEventsTimer startBuildingAggregateTimer |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	self
		logDebugMessage:
			(String
				streamContents: [ :s |
					s
						nextPutAll: 'Retrieving events for ';
						nextPutAll: anAggregateRootClass greaseString;
						nextPutAll: ' matching ';
						nextPutAll: aCommand aggregateSelectionCriteria greaseString;
						nextPutAll: '.' ]).
	startRetrievingEventsTimer := DateAndTime now.
	events := eventStore
		findEventsOfTenant: aCommand tenant
		ofAggregate: anAggregateRootClass
		whereCriteria: aCommand aggregateSelectionCriteria.
	startBuildingAggregateTimer := DateAndTime now.
	self
		logDebugMessage:
			(String
				streamContents: [ :s |
					s
						nextPutAll: events size greaseString;
						nextPutAll: ' event(s) retrieved in ';
						nextPutAll:
							(startBuildingAggregateTimer - startRetrievingEventsTimer)
								totalSeconds greaseString;
						nextPutAll: ' second(s).' ]).
	result := anAggregateRootClass new.
	self
		logDebugMessage:
			(String
				streamContents: [ :s |
					s
						nextPutAll: 'Applying ';
						nextPutAll: events size greaseString;
						nextPutAll: ' event(s) to an empty ';
						nextPutAll: anAggregateRootClass greaseString;
						nextPut: $. ]).
	result applyEvents: events.
	self
		logDebugMessage:
			(String
				streamContents: [ :s |
					s
						nextPutAll: 'Aggregate ';
						nextPutAll: result greaseString;
						nextPutAll: ' successfully built in ';
						nextPutAll:
							(DateAndTime now - startBuildingAggregateTimer) totalSeconds
								greaseString;
						nextPutAll: ' second(s).' ]).
	result version = aCommand aggregateRootVersion
		ifFalse: [ self
				logWarningMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Aggregate root''s version (';
								nextPutAll: result version greaseString;
								nextPutAll: ') does not match command''s (';
								nextPutAll: aCommand aggregateRootVersion greaseString;
								nextPutAll: ').' ]) ].
	^ result