setup
doSetup
	SettingBrowser open delete.
	self setupLogging.
	self setupEventAnnouncer.
	self setupEventProducer.
	self setupEventStore.
	self setupRepositories.
	self setupProjections.
	self projectionSynchronizationEnabled
		ifTrue: [ self setupProjectors ].
	self setupCommandDispatcher.
	self setupCommandConsumer.
	self setupEventSubscriptions