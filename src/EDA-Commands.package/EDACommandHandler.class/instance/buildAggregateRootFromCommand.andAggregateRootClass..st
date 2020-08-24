handling
buildAggregateRootFromCommand: aCommand andAggregateRootClass: anAggregateRootClass
	| result events startRetrievingEventsTimer startBuildingAggregateTimer |
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	self
		logDebugMessage:
			'Retrieving events for ' , anAggregateRootClass greaseString
				, ' matching ' , aCommand aggregateSelectionCriteria greaseString
				, '.'.
	startRetrievingEventsTimer := DateAndTime now.
	events := eventStore
		findEventsOfTenant: aCommand tenant ofAggregate: anAggregateRootClass
		whereCriteria: aCommand aggregateSelectionCriteria.
	startBuildingAggregateTimer := DateAndTime now.
	self
		logInfoMessage:
			events size greaseString , ' event(s) retrieved in '
				,
					(startBuildingAggregateTimer - startRetrievingEventsTimer)
						totalSeconds greaseString , ' second(s).'.
	result := anAggregateRootClass new.
	self
		logInfoMessage:
			'Applying ' , events size greaseString , ' event(s) to an empty '
				, anAggregateRootClass greaseString , '.'.
	result applyEvents: events.
	self
		logInfoMessage:
			'Aggregate ' , result greaseString , ' successfully built in '
				,
					(DateAndTime now - startBuildingAggregateTimer) totalSeconds
						greaseString , ' second(s).'.
	result version = aCommand aggregateRootVersion
		ifFalse: [ self
				logWarningMessage:
					'Aggregate root''s version (' , result version greaseString
						, ') does not match command''s ('
						, aCommand aggregateRootVersion greaseString , ').' ].
	^ result