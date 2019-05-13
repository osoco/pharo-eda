settings
edaTestSettingsOn: aBuilder under: parent withSettingsKey: aKey
	(aBuilder group: #edatests)
		label: 'EDA Tests' translated;
		description: 'EDA tests';
		noOrdering;
		parent: parent.
	self commandPublisherSettingsOn: aBuilder withSettingsKey: aKey.
	self eventListenerSettingsOn: aBuilder withSettingsKey: aKey.
	self queueCleaningSettingsOn: aBuilder withSettingsKey: aKey