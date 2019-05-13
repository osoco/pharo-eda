settings
queueCleaningSettingsOn: aBuilder withSettingsKey: aKey
	| extSettings |
	(aBuilder group: #testQueueCleaning)
		label: 'Queue cleaning' translated;
		description: 'Queue cleaning (for integration tests)' translated;
		parent: #edatests.
	extSettings := self retrieveSettingAsDict: 'queueCleaner' under: aKey.
	^ self
		queueCleanerSettingsOn: aBuilder
		withConfig: EDAQueueCleaner
		under: #testQueueCleaning
		populatedWithValuesFrom: extSettings