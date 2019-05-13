settings
edaSettingsOn: aBuilder for: application under: parent withSettingsKey: aKey
	(aBuilder group: #eda)
		label: 'Event-Driven Architecture' translated;
		description: 'Event-Driven Architecture settings';
		noOrdering;
		parent: parent.
	(aBuilder pickOne: #currentEnvironment)
		parent: #eda;
		target: EDADUEnvironment;
		label: 'Environment' translated;
		description: 'Environment';
		order: 1;
		domainValues: (EDADUEnvironment environments collect: [ :level | level translated -> level greaseString ]).
	application listensForCommands
		ifTrue: [ self commandListenerSettingsOn: aBuilder under: #eda withSettingsKey: aKey.
			self commandErrorHandlingStrategySettingsOn: aBuilder under: #eda ].
	application publishesEvents
		ifTrue: [ self eventPublisherSettingsOn: aBuilder under: #eda withSettingsKey: aKey ].
	application usesEventStore
		ifTrue: [ self eventStoreSettingsOn: aBuilder under: #eda withSettingsKey: aKey ].
	application usesProjections
		ifTrue: [ self projectionSettingsOn: aBuilder under: #eda populatedWithValuesFrom: 'projections' withSettingsKey: aKey ].
	self loggingSettingsOn: aBuilder under: #eda withSettingsKey: aKey