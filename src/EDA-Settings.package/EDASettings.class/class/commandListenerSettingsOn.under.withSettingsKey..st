settings
commandListenerSettingsOn: aBuilder under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'CommandListener') asSymbol.
	(aBuilder group: symbol)
		label: 'Command Listener' translated;
		description: 'Command listener';
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: self commandStompTopicListenerContainer
		under: symbol
		populatedWithValuesFrom: 'commandListener'
		withSettingsKey: aKey.
	(aBuilder pickOne: #strategy)
		parent: #commandListener;
		target: EDACommandConsumingErrorBehavior;
		label: 'Command Consuming Error' translated;
		description: 'Strategy when dealing with command consuming errors';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
	^ self
