settings
edaTestSettingsOn: aBuilder under: parent withSettingsKey: aKey
	self commandPublisherSettingsOn: aBuilder under: parent withSettingsKey: aKey.
	self eventListenerSettingsOn: aBuilder under: parent withSettingsKey: aKey.
	self queueCleaningSettingsOn: aBuilder under: parent withSettingsKey: aKey