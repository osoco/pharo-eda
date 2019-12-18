class initialization
doInitialize
	super doInitialize.
	self concurrentSynchronization: false.
	self executions: Dictionary new