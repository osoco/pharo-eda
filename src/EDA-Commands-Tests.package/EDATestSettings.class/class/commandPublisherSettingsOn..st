settings
commandPublisherSettingsOn: aBuilder
	(aBuilder group: #testCommandPublisher)
		label: 'Command Publisher' translated;
		description: 'Command Publisher (for integration tests)' translated;
		parent: #edatests.

	^ self stompPublisherSettingsOn: aBuilder withConfig: EDACommandStompTopicPublisher under: #testCommandPublisher populatedWithValuesFrom: 'testCommandPublisher'
		