settings
eventListenerSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'testEventListener') asSymbol.
	(aBuilder group: symbol)
		label: 'Event Listener' translated;
		description: 'Event Listener (for integration tests)' translated;
		parent: parent.
	^ self
		stompListenerSettingsOn: aBuilder
		withConfig: self eventStompTopicListenerContainer
		under: symbol
		populatedWithValuesFrom: 'testEventListener'
		withSettingsKey: aKey