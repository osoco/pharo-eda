class initialization
doInitialize
	self host: nil.
	self port: nil.
	self databaseName: nil.
	self username: nil.
	self password: nil.
	self debug: false.
	self enableReplication: false.
	self enableSingleton: true.
	self ensuringCurrentOnSave: false.
	self ensuringCurrentReferencesOnQueries: false.
	self forceEager: false.
	self lazySynchronize: true.
	self wireProtocolEnabled: true