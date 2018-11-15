settings
edaSettingsOn: aBuilder
	<systemsettings>
	| parent |
	parent := EDAApplication subclasses first settingsGroup.
	(aBuilder group: #eda)
		label: 'EDA' translated;
		description: 'Event-Driven Architecture' translated;
		noOrdering;
		parent: parent.
	self commandListenerSettingsOn: aBuilder under: #eda.
	self eventPublisherSettingsOn: aBuilder under: #eda.
	self eventStoreSettingsOn: aBuilder under: #eda.
	self projectionSettingsOn: aBuilder under: #eda populatedWithValuesFrom: 'projections'.
	self commandErrorHandlingStrategySettingsOn: aBuilder under: #eda.
	self loggingSettingsOn: aBuilder under: parent