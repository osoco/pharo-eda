settings
commandDispatchingErrorStrategySettingsOn: aBuilder under: parent
	(aBuilder pickOne: #strategy)
		parent: parent;
		target: EDACommandDispatchingErrorBehavior;
		label: 'Command Dispatching Error' translated;
		description: 'Strategy when dealing with command dispatching errors';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
	^ self