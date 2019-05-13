settings
commandListenerSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'CommandListener') asSymbol.
	(aBuilder group: symbol)
		label: 'Command Listener' translated;
		description: 'Command listener' translated;
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: self commandStompTopicListenerContainer
		under: symbol
		populatedWithValuesFrom: 'commandListener'
		withSettingsKey: aKey