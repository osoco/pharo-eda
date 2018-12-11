tests
testRetrieveAggregateIdNames_does_not_include_aggregates_from_other_applications
	| instance |
	instance := AbstractEDAGenerator new.
	instance appName: 'OTHER'.
	self assert: (instance retrieveAggregateIdNames includes: 'dummyAggregateRootId') not.
		self assert: (instance retrieveAggregateIdNames includes: 'eDADummyAggregateRootId') not.