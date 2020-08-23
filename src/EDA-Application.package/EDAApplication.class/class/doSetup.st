setup
doSetup
	SettingBrowser open delete.
	self setupLogging.
	self setupEventAnnouncer.
	self setupEventProducer.
	self setupEventStore.
	self setupRepositories.
	self setupProjections.
	self setupProjectors.
	self projectionSynchronizationEnabled
		ifTrue: [ self synchronizeProjections ].
	self setupCommandDispatcher.
	self setupCommandConsumer.
	self setupEventSubscriptions