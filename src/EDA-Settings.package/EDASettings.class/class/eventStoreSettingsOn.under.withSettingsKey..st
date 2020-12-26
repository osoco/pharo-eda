settings
eventStoreSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol extSettings |
	symbol := (parent greaseString , 'EventStore') asSymbol.
	extSettings := self retrieveSettingAsDict: 'eventStore' under: aKey.
	(aBuilder group: symbol)
		label: 'Event Store' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: self mongoEventStoreContainer
		under: symbol
		populatedWithValuesFrom: extSettings