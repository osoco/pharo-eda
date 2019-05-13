settings
eventPublisherSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'EventPublisher') asSymbol.
	(aBuilder group: symbol)
		label: 'Event Publisher' translated;
		description: 'Event publisher (for integration tests)' translated;
		parent: parent.
	^ self
		stompPublisherSettingsOn: aBuilder
		withConfig: self eventStompTopicPublisherContainer
		under: symbol
		populatedWithValuesFrom: 'eventPublisher'
		withSettingsKey: aKey