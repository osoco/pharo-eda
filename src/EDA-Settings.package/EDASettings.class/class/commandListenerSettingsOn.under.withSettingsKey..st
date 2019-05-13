settings
commandListenerSettingsOn: aBuilder under: parent withSettingsKey: aKey
	(aBuilder group: #commandListener)
		label: 'Command Listener' translated;
		description: 'Command listener' translated;
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: EDACommandStompTopicListener
		under: #commandListener
		populatedWithValuesFrom: 'commandListener'
		withSettingsKey: aKey