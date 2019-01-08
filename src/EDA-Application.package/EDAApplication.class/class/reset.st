reset
reset
	self resetLogging.
	self resetEventProducer.
	self resetEventStore.
	self resetRepositories.
	self resetProjections.
	self resetProjector.
	self resetCommandDispatcher.
	self resetCommandConsumer.
	self resetEventSubscriptions.
	self resetEventAnnouncer
