tests
testRetrieveAggregateClasses
	| instance |
	instance := AbstractEDAGenerator new.
	self assert: (instance retrieveAggregateClasses select: [ :c | c class greaseString = 'EDADummyAggregateRoot class' ]) isNotEmpty