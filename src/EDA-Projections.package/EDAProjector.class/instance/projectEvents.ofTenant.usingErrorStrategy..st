projection retrieval
projectEvents: anEventCollection ofTenant: aTenant usingErrorStrategy: anErrorStrategy
	(self isSynchronized: anEventCollection ofTenant: aTenant)
		ifFalse: [ self synchronizeEvents: anEventCollection ofTenant: aTenant]