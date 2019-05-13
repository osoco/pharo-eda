settings
eventStoreSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| extSettings |
	extSettings := self retrieveSettingAsDict: 'eventStore' under: aKey.
	(aBuilder group: #eventStore)
		label: 'Event Store' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: EDAMongoEventStore
		under: #eventStore
		populatedWithValuesFrom: extSettings