projection retrieval
projectEvents: anEventCollection usingErrorStrategy: anErrorStrategy
	(self isSynchronized: anEventCollection)
		ifFalse: [ self synchronizeEvents: anEventCollection ]