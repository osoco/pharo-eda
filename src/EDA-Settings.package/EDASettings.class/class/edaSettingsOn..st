settings
edaSettingsOn: aBuilder
	<systemsettings>
	| parents |
	parents := EDAApplication subclasses ifNil: [ OrderedCollection new ].
	parents
		do: [ :application | 
			| parent |
			parent := application settingsGroup.
			(aBuilder group: #eda)
				label: 'Event-Driven Architecture' translated;
				description: 'Event-Driven Architecture settings';
				noOrdering;
				parent: parent.
			(aBuilder pickOne: #currentEnvironment)
				parent: #eda;
				target: EDADUEnvironment;
				label: 'Environment' translated;
				description: 'Environment';
				order: 1;
				domainValues:
					(EDADUEnvironment environments
						collect: [ :level | level translated -> level greaseString ]).
			application listensForCommands
				ifTrue: [ self commandListenerSettingsOn: aBuilder under: #eda.
					self commandErrorHandlingStrategySettingsOn: aBuilder under: #eda ].
			application publishesEvents
				ifTrue: [ self eventPublisherSettingsOn: aBuilder under: #eda ].
			application usesEventStore
				ifTrue: [ self eventStoreSettingsOn: aBuilder under: #eda ].
			application usesProjections
				ifTrue: [ self projectionSettingsOn: aBuilder under: #eda populatedWithValuesFrom: 'projections' ] ].
	self loggingSettingsOn: aBuilder under: #eda