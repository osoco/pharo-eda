lifecycle
clearPreviousEvents
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAEventSourcingEvent removeAll ]
		ifFalse: [ self fail: 'Not in integration test environment' ]