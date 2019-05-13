settings
loggingSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol extSettings |
	symbol := (parent greaseString , 'Logging') asSymbol.
	extSettings := self retrieveSettingAsDict: 'logging' under: aKey.
	(aBuilder group: symbol)
		label: 'Logging' translated;
		parent: parent.
	(aBuilder pickOne: #loggingLevel)
		parent: symbol;
		target: self loggingSettingsContainer;
		label: 'Logging level' translated;
		description: 'Logging level' translated;
		order: 1;
		domainValues: (EDALoggingSettings levels collect: [ :level | level translated -> level greaseString ]);
		default: (extSettings at: 'level')