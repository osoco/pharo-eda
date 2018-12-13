lifecycle
clearPreviousProjections
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAProjection removeAllProjections ]
		ifFalse: [ self fail: 'Not in integration test environment' ]
	