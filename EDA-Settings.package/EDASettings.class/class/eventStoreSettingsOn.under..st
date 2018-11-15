settings
eventStoreSettingsOn: aBuilder under: parent
   | extSettings |
extSettings := self retrieveSettingAsDict: 'eventStore'.
	(aBuilder group: #eventStore)
		label: 'Events Store' translated;
		parent: parent.

	^ self mongoSettingsOn: aBuilder withConfig: EDAMongoEventStore under: #eventStore populatedWithValuesFrom: extSettings
		