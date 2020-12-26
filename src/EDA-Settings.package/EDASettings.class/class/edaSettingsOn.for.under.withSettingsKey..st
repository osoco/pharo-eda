settings
edaSettingsOn: aBuilder for: application under: parent withSettingsKey: aKey
	| symbol |
	symbol := (parent greaseString , 'Eda') asSymbol.
	Transcript
		show:
			'Starting eda settings on ' , aKey , ' under ' , symbol greaseString , aBuilder nodeList greaseString , '.'
				, Character cr greaseString.
	(aBuilder group: symbol)
		label: 'Event-Driven Architecture' translated;
		description: 'Event-Driven Architecture settings';
		noOrdering;
		parent: parent.
	(aBuilder pickOne: #currentEnvironment)
		parent: symbol;
		target: EDADUEnvironment;
		label: 'Environment' translated;
		description: 'Environment';
		order: 1;
		domainValues: (EDADUEnvironment environments collect: [ :level | level translated -> level greaseString ]).
	application listensForCommands
		ifTrue: [ self commandListenerSettingsOn: aBuilder under: symbol withSettingsKey: aKey.
			self commandErrorHandlingStrategySettingsOn: aBuilder under: symbol ].
	application publishesEvents
		ifTrue: [ self eventPublisherSettingsOn: aBuilder under: symbol withSettingsKey: aKey ].
	application usesEventStore
		ifTrue: [ self eventStoreSettingsOn: aBuilder under: symbol withSettingsKey: aKey ].
	application usesProjections
		ifTrue: [ self
				projectionSettingsOn: aBuilder
				under: symbol
				populatedWithValuesFrom: 'projections'
				withSettingsKey: aKey ].
	self loggingSettingsOn: aBuilder under: symbol withSettingsKey: aKey.
	Transcript show: 'Ending EDA settings on ' , aKey , Character cr greaseString