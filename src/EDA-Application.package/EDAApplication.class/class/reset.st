reset
reset
	self resetLogging.
	self resetEventProducer.
	self resetEventStore.
	self resetRepositories.
	self resetProjections.
	self resetProjectors.
	self resetCommandDispatcher.
	self resetCommandConsumer.
	self resetEventSubscriptions.
	self resetEventAnnouncer.
	self isConfigured: false