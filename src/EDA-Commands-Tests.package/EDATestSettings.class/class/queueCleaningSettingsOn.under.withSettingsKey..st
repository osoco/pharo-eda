settings
queueCleaningSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| extSettings symbol |
	symbol := (parent greaseString , 'testQueueCleaning') asSymbol.
	(aBuilder group: symbol)
		label: 'Queue cleaning' translated;
		description: 'Queue cleaning (for integration tests)' translated;
		parent: parent.
	extSettings := (self retrieveSettingAsDict: 'queueCleaner' under: aKey) ifNil: [ Dictionary new ].
	^ self
		queueCleanerSettingsOn: aBuilder
		withConfig: self queueCleaner
		under: symbol
		populatedWithValuesFrom: extSettings