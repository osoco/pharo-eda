settings
loggingSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| extSettings |
	extSettings := self retrieveSettingAsDict: 'logging' under: aKey.
	(aBuilder group: #logging)
		label: 'Logging' translated;
		parent: parent.
	(aBuilder pickOne: #loggingLevel)
		parent: #logging;
		target: EDALoggingSettings;
		label: 'Logging level' translated;
		description: 'Logging level' translated;
		order: 1;
		domainValues: (EDALoggingSettings levels collect: [ :level | level translated -> level greaseString ]);
		default: (extSettings at: 'level')