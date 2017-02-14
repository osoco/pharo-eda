initialization
setup
	self setupProjectionRepository.
	self setupEventProducer.
	self setupEventStore.
	self setupCommandDispatcher.
	self setupCommandConsumer.
