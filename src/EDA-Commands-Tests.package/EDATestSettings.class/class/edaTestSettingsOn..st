settings
edaTestSettingsOn: aBuilder
	<systemsettings>

	(aBuilder group: #edatests)
		label: 'EDA Tests' translated;
		description: 'EDA tests';
		noOrdering;
		parent: #eda.
	self commandPublisherSettingsOn: aBuilder.
	self eventListenerSettingsOn: aBuilder.
	self queueCleaningSettingsOn: aBuilder