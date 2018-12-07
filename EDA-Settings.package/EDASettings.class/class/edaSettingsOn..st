settings
edaSettingsOn: aBuilder
	<systemsettings>
	| parent |
	parent := EDAApplication subclasses first settingsGroup.
	(aBuilder group: #eda)
		label: 'Event-Driven Architecture' translated;
		description: 'Event-Driven Architecture settings';
		noOrdering;
		parent: parent.
	(aBuilder pickOne: #currentEnvironment)
		parent: #eda;
		target: EDADUEnvironment;
		label: 'Environment' translated;
		description: 'Environment' translated;
		order: 1;
		domainValues: (EDADUEnvironment environments collect: [ :level | level translated -> level greaseString ]).
	self commandListenerSettingsOn: aBuilder under: #eda.
	self eventPublisherSettingsOn: aBuilder under: #eda.
	self eventStoreSettingsOn: aBuilder under: #eda.
	self projectionSettingsOn: aBuilder under: #eda populatedWithValuesFrom: 'projections'.
	self commandErrorHandlingStrategySettingsOn: aBuilder under: #eda.
	self loggingSettingsOn: aBuilder under: parent