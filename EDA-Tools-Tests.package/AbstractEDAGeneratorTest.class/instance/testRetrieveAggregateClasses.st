tests
testRetrieveAggregateClasses
	| instance |
	instance := AbstractEDAGenerator new.
	self assert: (instance retrieveAggregateClasses includes: EDADummyAggregateRoot)