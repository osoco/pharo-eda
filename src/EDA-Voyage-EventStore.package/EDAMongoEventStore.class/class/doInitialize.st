class initialization
doInitialize
	self urls: nil.
	self tls: false.
	self databaseName: nil.
	self username: nil.
	self password: nil.
	self debug: false.
	self enableReplication: false.
	self enableSingleton: nil.
	self ensuringCurrentOnSave: false.
	self ensuringCurrentReferencesOnQueries: false.
	self forceEager: false.
	self lazySynchronize: true.
	self wireProtocolEnabled: true