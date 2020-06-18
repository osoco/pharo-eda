settings
commandErrorHandlingStrategySettingsOn: aBuilder under: parent
	(aBuilder pickOne: #commandErrorHandlingStrategy)
		parent: parent;
		target: EDACommandDispatcher;
		label: 'Command Error Handling' translated;
		description: 'Strategy when dealing with errors processing commands';
		order: 1;
		domainValues:
			(EDACommandErrorHandlingStrategy subclasses
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAErrorAsEventStrategy greaseString.
	^ self