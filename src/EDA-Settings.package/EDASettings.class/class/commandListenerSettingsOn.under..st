settings
commandListenerSettingsOn: aBuilder under: parent
	(aBuilder group: #commandListener)
		label: 'Command Listener' translated;
		description: 'Command listener';
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: EDACommandStompTopicListener
		under: #commandListener
		populatedWithValuesFrom: 'commandListener'