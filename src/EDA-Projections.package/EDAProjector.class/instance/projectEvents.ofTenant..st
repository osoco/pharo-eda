projection retrieval
projectEvents: anEventCollection ofTenant: aTenant
	anEventCollection
		ifNotEmpty: [ (self isSynchronized: anEventCollection ofTenant: aTenant)
				ifFalse: [ self synchronizeEvents: anEventCollection ofTenant: aTenant] ]