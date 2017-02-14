settings
edaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder group: #osoco)
		label: 'Osoco' translated;
		description: 'Osoco settings' translated;
		noOrdering.
	(aBuilder group: #eda)
		label: 'EDA' translated;
		description: 'Event-Driven Architecture' translated;
		noOrdering;
		parent: #osoco.

	self commandListenerSettingsOn: aBuilder under: #eda.
	self eventPublisherSettingsOn: aBuilder under: #eda.
	self eventStoreSettingsOn: aBuilder under: #eda.
	self projectionsRepositorySettingsOn: aBuilder under: #eda.
	self commandErrorHandlingStrategySettingsOn: aBuilder under: #eda