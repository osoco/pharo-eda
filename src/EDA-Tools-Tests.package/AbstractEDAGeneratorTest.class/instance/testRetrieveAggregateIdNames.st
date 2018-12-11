tests
testRetrieveAggregateIdNames
	| instance |
	instance := AbstractEDAGenerator
		new.
		instance 
		appName: 'EDA'.
	self assert: (instance retrieveAggregateIdNames includes: 'dummyAggregateRootId')