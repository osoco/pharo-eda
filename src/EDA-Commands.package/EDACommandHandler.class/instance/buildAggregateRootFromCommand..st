handling
buildAggregateRootFromCommand: aCommand
	^ self buildAggregateRootFromCommand: aCommand andAggregateRootClass: (self retrieveAggregateRootClass: aCommand)