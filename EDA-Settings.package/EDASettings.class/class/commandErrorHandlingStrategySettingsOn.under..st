settings
commandErrorHandlingStrategySettingsOn: t1 under: parent
	(t1 pickOne: #commandErrorHandlingStrategy)
		parent: parent;
		target: EDACommandDispatcher;
		label: 'Command Error Handling' translated;
		description: 'Strategy when dealing with errors processing commands' translated;
		order: 1;
		domainValues: (EDACommandErrorHandlingStrategy subclasses collect: [ :t2 | t2 description translated -> t2 asString ]).
	^ self