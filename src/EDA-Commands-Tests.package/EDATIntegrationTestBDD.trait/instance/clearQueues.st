lifecycle
clearQueues
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAQueueCleaner new deleteAllQueues ]
		ifFalse: [ self fail: 'Not in integration test environment' ]