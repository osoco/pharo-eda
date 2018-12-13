projection retrieval
projectEvents: anEventCollection
	(self isSynchronized: anEventCollection)
		ifFalse: [ self synchronizeEvents: anEventCollection ]