refresh settings
refreshVoyageSettingsOn: aRepository
	aRepository username: self username.
	aRepository password: self password.
	aRepository debug: self debug.
	self enableReplication
		ifTrue: [ aRepository enableReplication ]
		ifFalse: [ aRepository disableReplication ].
	aRepository ensuringCurrentOnSave: self ensuringCurrentOnSave.
	aRepository ensuringCurrentReferencesOnQueries: self ensuringCurrentReferencesOnQueries.
	aRepository forceEager: self forceEager.
	aRepository lazySynchronize: self lazySynchronize.
	self enableSingleton
		ifTrue: [ aRepository enableSingleton ]
		ifFalse: [ aRepository disableSingleton ].
	aRepository wireProtocolEnabled: self wireProtocolEnabled