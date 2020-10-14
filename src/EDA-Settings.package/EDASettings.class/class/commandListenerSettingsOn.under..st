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
		populatedWithValuesFrom: 'commandListener'.
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