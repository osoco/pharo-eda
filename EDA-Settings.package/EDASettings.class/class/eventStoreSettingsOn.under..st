settings
eventStoreSettingsOn: aBuilder under: parent
	(aBuilder group: #eventStore)
		label: 'Events Store' translated;
		parent: parent.

	^ self mongoSettingsOn: aBuilder withConfig: EDAMongoEventStore under: #eventStore populatedWithValuesFrom: 'eventStore'
