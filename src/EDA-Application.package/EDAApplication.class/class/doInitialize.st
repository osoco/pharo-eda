class initialization
doInitialize
	self isStarted: false.
	self isConfigured: false.
	self projectorsByTenant: Dictionary new