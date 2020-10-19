initialization
retrieveAggregateRootClass: commandParams
	^ (self retrieveCommandClassFromJsonDict: commandParams) new aggregateRootClass