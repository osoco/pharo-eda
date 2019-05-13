settings
projectionSettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry withSettingsKey: aKey
	| extSettings |
	extSettings := self retrieveSettingAsDict: aConfigEntry under: aKey.
	(aBuilder group: #projections)
		label: 'Projections' translated;
		parent: parent.
	self projectionsRepositorySettingsOn: aBuilder under: #projections populatedWithValuesFrom: (extSettings at: 'projectionsRepository').
	(aBuilder setting: #projectionSynchronizationEnabled)
		parent: #projections;
		target: EDAApplication;
		label: 'Synchronize on startup' translated;
		description: 'When the EDAApplication starts, this setting enables a check and conditional automatic synchronization of projections' translated;
		default: (extSettings at: 'synchronizationEnabled').
	(aBuilder pickOne: #errorStrategy)
		parent: #projections;
		target: EDAProjector;
		label: 'Projection Error Handling' translated;
		description: 'Strategy when dealing with errors projecting events' translated;
		order: 1;
		domainValues: (EDAProjectionErrorHandlingStrategy subclasses collect: [ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAJustLoggingProjectionErrorHandlingStrategy greaseString.
	(aBuilder setting: #concurrentSynchronization)
		parent: #projections;
		target: EDACompositeProjector;
		label: 'Synchronization in parallel' translated;
		description: 'Whether enable or disable concurrent projection synchronization' translated;
		order: 2;
		default: (extSettings at: 'concurrentSynchronization').
	(aBuilder setting: #headlessMode)
		parent: #projections;
		target: EDAProjector;
		label: 'Headless' translated;
		description: 'Whether to show the progress when projecting events visually' translated;
		order: 3;
		default: (extSettings at: 'headlessMode')