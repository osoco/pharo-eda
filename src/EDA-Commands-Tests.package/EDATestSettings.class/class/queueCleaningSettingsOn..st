settings
queueCleaningSettingsOn: aBuilder
	| extSettings |
	(aBuilder group: #testQueueCleaning)
		label: 'Queue cleaning' translated;
		description: 'Queue cleaning (for integration tests)' translated;
		parent: #edatests.
	extSettings := self retrieveSettingAsDict: 'queueCleaner'.
	^ self
		queueCleanerSettingsOn: aBuilder
		withConfig: EDAQueueCleaner
		under: #testQueueCleaning
		populatedWithValuesFrom: extSettings