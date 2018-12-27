projection retrieval
projectEvents: anEventCollection
	anEventCollection ifNotEmpty: [
	(self isSynchronized: anEventCollection)
		ifFalse: [ self synchronizeEvents: anEventCollection ] ]