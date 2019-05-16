settings
commandPublisherSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'testCommandPublisher') asSymbol.
	(aBuilder group: symbol)
		label: 'Command Publisher' translated;
		description: 'Command Publisher (for integration tests)' translated;
		parent: parent.
	^ self
		stompPublisherSettingsOn: aBuilder
		withConfig: self commandStompTopicPublisherContainer
		under: symbol
		populatedWithValuesFrom: 'testCommandPublisher'
		withSettingsKey: aKey