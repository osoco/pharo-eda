"
* Class: EDASettings

Manages the configuration settings of EDA, using Pharo Settings framework, and injecting default values from config/[environment].json files.

* Responsibility: 

Build Settings menu entries with EDA-specific configuration settings, for the user to manage.
"
Class {
	#name : #EDASettings,
	#superclass : #Object,
	#traits : 'EDATSettingsHelper + EDATLogging',
	#classTraits : 'EDATSettingsHelper classTrait + EDATLogging classTrait',
	#classInstVars : [
		'duEnvironmentClass',
		'noApplications',
		'priorizedAdapter'
	],
	#category : #'EDA-Settings'
}

{ #category : #settings }
EDASettings class >> commandListenerSettingsOn: aBuilder under: parent on: app [
	| key |
	key := parent , 'commandListener'.
	(aBuilder group: key)
		label: 'Command Listener' translated;
		description: 'Command listener';
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: app commandListenerSettingsPort
		under: key
		populatedWithValuesFrom: 'commandListener'.
	(aBuilder pickOne: #strategy)
		parent: key;
		target: app commandListenerSettingsPort;
		label: 'Command Consuming Error' translated;
		description: 'Strategy when dealing with command consuming errors';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
	^ self
]

{ #category : #settings }
EDASettings class >> customProjectionErrorBehaviorsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry [
	EDAProjectionErrorBehavior subclasses
		doWithIndex: [ :behavior :index | 
			(aBuilder pickOne: #strategy)
				parent: #errors;
				target: behavior;
				label: behavior label translated;
				description: behavior label translated;
				order: index + 1;
				domainValues:
					(EDAErrorHandlingStrategy subclasses
						collect: [ :strategy | strategy description -> strategy greaseString ]);
				default: EDAPublishMessageErrorStrategy greaseString ]
]

{ #category : #accessing }
EDASettings class >> duEnvironmentClass [
	^ duEnvironmentClass
]

{ #category : #accessing }
EDASettings class >> duEnvironmentClass: envClass [
	duEnvironmentClass := envClass
]

{ #category : #settings }
EDASettings class >> edaSettingsOn: aBuilder [
	<systemsettings>
	| root rootSymbol |
	rootSymbol := #edaApps.
	root := aBuilder group: rootSymbol.
	EDAApplications uniqueInstance edaApplications
		ifEmpty: [ root
				label: 'No PharoEDA applications registered' translated;
				description: 'No PharoEDA applications registered' ]
		ifNotEmpty: [ :apps | 
			root
				label: 'PharoEDA application(s)' translated , ': ' , apps size printString;
				description: 'Registered PharoEDA applications';
				noOrdering.
			apps
				do: [ :app | self edaSettingsOn: aBuilder for: app under: rootSymbol ] ]
]

{ #category : #settings }
EDASettings class >> edaSettingsOn: aBuilder for: anEDAApplication under: aSymbol [
	| parent parentGroup |
	parent := anEDAApplication applicationName.
	parentGroup := aBuilder group: parent.
	parentGroup
		label: parent translated;
		parent: aSymbol;
		description: parent;
		noOrdering.
	self
		environmentSettingsOn: aBuilder
		under: parent
		on: anEDAApplication.
	self
		commandListenerSettingsOn: aBuilder
		under: parent
		on: anEDAApplication.
	self
		eventPublisherSettingsOn: aBuilder
		under: parent
		on: anEDAApplication.
	self
		eventStoreSettingsOn: aBuilder
		under: parent
		on: anEDAApplication.
	self
		projectionSettingsOn: aBuilder
		under: parent
		populatedWithValuesFrom: 'projections'
		on: anEDAApplication.
	self loggingSettingsOn: aBuilder under: parent on: anEDAApplication.
	self portSettingsOn: aBuilder under: parent on: anEDAApplication
]

{ #category : #settings }
EDASettings class >> environmentSettingsOn: aBuilder under: aParent on: app [
	^ self
		settingOn: aBuilder
		named: #currentEnvironment
		labelled: 'Environment'
		withDescription: 'Environment'
		usingConfig:  app environmentSettingsPort
		under: aParent
		on: app
]

{ #category : #settings }
EDASettings class >> eventPublisherSettingsOn: aBuilder under: parent on: app [
	| key |
	key := parent , 'eventPublisher'.
	(aBuilder group: key)
		label: 'Event Publisher' translated;
		description: 'Event publisher (for integration tests)';
		parent: parent.
	^ self
		stompPublisherSettingsOn: aBuilder
		withConfig: app eventPublisherSettingsPort
		under: key
		populatedWithValuesFrom: 'eventPublisher'
]

{ #category : #settings }
EDASettings class >> eventStoreSettingsOn: aBuilder under: parent on: app [
	| extSettings key |
	key := parent , 'eventStore'.
	extSettings := self retrieveSettingAsDict: 'eventStore'.
	(aBuilder group: key)
		label: 'Event Store' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: app eventStoreSettingsPort
		under: key
		populatedWithValuesFrom: extSettings
		on: app
]

{ #category : #initialization }
EDASettings class >> initialize [
	self duEnvironmentClass: EDADUEnvironment

]

{ #category : #settings }
EDASettings class >> loggingSettingsOn: aBuilder under: parent on: app [
	| extSettings key |
	key := parent , 'logging'.
	extSettings := self retrieveSettingAsDict: 'logging'.
	(aBuilder group: key)
		label: 'Logging' translated;
		parent: parent.
	(aBuilder pickOne: #loggingLevel)
		parent: key;
		target: app loggingSettingsPort;
		label: 'Logging level' translated;
		description: 'Logging level';
		order: 1;
		domainValues:
			(EDALoggingSettings levels
				collect: [ :level | level translated -> level greaseString ]);
		default: (extSettings at: 'level')
]

{ #category : #settings }
EDASettings class >> mongoSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: mongoConfig on: app [
	(aBuilder setting: #urls)
		parent: parent;
		target: container;
		label: 'Urls' translated;
		description: 'Comma-separated MongoDB urls';
		order: 1;
		default: (mongoConfig at: 'urls' ifAbsent: 'mondodb://localhost:27017/admin').
	(aBuilder setting: #tls)
		parent: parent;
		target: container;
		label: 'Use TLS' translated;
		description: 'Whether to connect using TLS';
		default: (mongoConfig at: 'tls' ifAbsent: false).
	self
		mongodbUsernameSettingOn: aBuilder
		withConfig: container
		under: parent
		on: app.
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'Mongo password' translated;
		description: 'Mongo password';
		default: (mongoConfig at: 'password' ifAbsent: 'secret').
	(aBuilder setting: #databaseName)
		parent: parent;
		target: container;
		label: 'Mongo database' translated;
		description: 'Mongo database name';
		default: (mongoConfig at: 'database' ifAbsent: 'eda').
	(aBuilder pickOne: #authenticationMechanism)
		parent: parent;
		target: container;
		label: 'AuthenticationMechanism' translated;
		description: 'AuthenticationMechanism';
		domainValues:
			((MongoAuthMechanism allSubclasses reject: [ :item | item isAbstract ])
				collect: [ :item | item textDescription -> item ]);
		default:
			(MongoAuthMechanism allSubclasses
				select: [ :item | 
					item isAbstract not
						and: [ item textDescription = (mongoConfig at: 'authenticationMechanism' ifAbsent: 'SCRAM-SHA-1') ] ])
				first.
	(aBuilder setting: #debug)
		parent: parent;
		target: container;
		label: 'Debug' translated;
		description: 'Debug';
		default: (mongoConfig at: 'debug' ifAbsent: true).
	(aBuilder setting: #enableReplication)
		parent: parent;
		target: container;
		label: 'Enable replication' translated;
		description: 'Enable replication';
		default: (mongoConfig at: 'enableReplication' ifAbsent: false).
	(aBuilder setting: #enableSingleton)
		parent: parent;
		target: container;
		label: 'Enable singleton' translated;
		description: 'Enable singleton';
		default: (mongoConfig at: 'enableSingleton' ifAbsent: true).
	(aBuilder setting: #ensuringCurrentOnSave)
		parent: parent;
		target: container;
		label: 'Current on save' translated;
		description: 'Ensure current on save';
		default: (mongoConfig at: 'ensuringCurrentOnSave' ifAbsent: true).
	(aBuilder setting: #ensuringCurrentReferencesOnQueries)
		parent: parent;
		target: container;
		label: 'Current references on queries' translated;
		description: 'Ensure current references on queries';
		default: (mongoConfig at: 'ensuringCurrentReferencesOnQueries' ifAbsent: true).
	(aBuilder setting: #lazySynchronize)
		parent: parent;
		target: container;
		label: 'Lazy synchronize';
		description: 'Lazy synchronize';
		default: (mongoConfig at: 'lazySynchronize' ifAbsent: true).
	(aBuilder setting: #wireProtocolEnabled)
		parent: parent;
		target: container;
		label: 'Wire protocol' translated;
		description: 'Whether to enable wire protocol';
		default: (mongoConfig at: 'wireProtocolEnabled' ifAbsent: true)
]

{ #category : #settings }
EDASettings class >> mongodbUsernameSettingOn: aBuilder withConfig: aConfig under: aParent on: app [
	^ self
		settingOn: aBuilder
		named: #username
		labelled: 'MongoDB user name'
		withDescription: 'The name of the MongoDB user'
		usingConfig: aConfig
		under: aParent
		on: app
]

{ #category : #settings }
EDASettings class >> portSettingsOn: aBuilder under: aParent on: app [
	| entry values byPriorityAdapter key |
	key := aParent , 'ports'.
	entry := aBuilder group: key.
	entry
		label: 'Ports' translated;
		parent: aParent.
	byPriorityAdapter := EDAPortResolverByPriorityAdapter new.
	priorizedAdapter := byPriorityAdapter resolveEnvironmentSettingsPort.
	values := OrderedCollection
		with:
			('By priority (' , priorizedAdapter class description , ')')
				-> EDAPortResolverByPriorityAdapter.
	values
		addAll:
			((EDAPortResolverByPriorityAdapter new
				availableEnvironmentSettingsAdapters
				reject: [ :adapterClass | adapterClass = priorizedAdapter class ]
				thenCollect:
					[ :adapterClass | adapterClass description translated -> adapterClass ])
				sorted: [ :a :b | a value < b value ]).
	(aBuilder pickOne: #environmentSettingsResolverPortClass)
		label: 'Environment adapter' translated;
		target: app portSettingsPort;
		parent: key;
		domainValues: values
]

{ #category : #settings }
EDASettings class >> projectionErrorHandlingSettingsOn: aBuilder withConfig: aConfig under: parent populatedWithValuesFrom: aConfigEntry on: app [
	| key |
	key := parent , 'errors'.
	(aBuilder group: key)
		label: 'Projection errors' translated;
		description: 'Projection error handling';
		noOrdering;
		parent: parent.
	(aBuilder pickOne: #strategy)
		parent: key;
		target: aConfig;
		label: 'Default projection Error Handling' translated;
		description: 'Default strategy when dealing with errors projecting events';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect: [ :strategy | strategy description -> strategy printString ]);
		default: EDAPublishMessageErrorStrategy printString.
	self
		customProjectionErrorBehaviorsOn: aBuilder
		withConfig: aConfig
		under: key
		populatedWithValuesFrom: aConfigEntry
		on: app
]

{ #category : #settings }
EDASettings class >> projectionSettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry on: app [
	| extSettings key |
	key := parent , 'projections'.
	extSettings := self retrieveSettingAsDict: aConfigEntry.
	(aBuilder group: key)
		label: 'Projections' translated;
		parent: parent.
	self
		projectionsRepositorySettingsOn: aBuilder
		withConfig: app projectionSettingsPort
		under: key
		populatedWithValuesFrom: (extSettings at: 'projectionsRepository')
		on: app.
	(aBuilder setting: #projectionSynchronizationEnabled)
		parent: key;
		target: app projectionSettingsPort;
		label: 'Synchronize on startup' translated;
		description:
			'When the EDAApplication starts, this setting enables a check and conditional automatic synchronization of projections';
		default: (extSettings at: 'synchronizationEnabled').
	(aBuilder setting: #concurrentSynchronization)
		parent: key;
		target: app projectionSettingsPort;
		label: 'Synchronization in parallel' translated;
		description: 'Whether enable or disable concurrent projection synchronization';
		order: 2;
		default: (extSettings at: 'concurrentSynchronization').
	(aBuilder setting: #headlessMode)
		parent: key;
		target: app projectionSettingsPort;
		label: 'Headless' translated;
		description: 'Whether to show the progress when projecting events visually';
		order: 3;
		default: (extSettings at: 'headlessMode').
	self
		projectionErrorHandlingSettingsOn: aBuilder
		withConfig: app projectionSettingsPort
		under: parent
		populatedWithValuesFrom: aConfigEntry
		on: app
]

{ #category : #settings }
EDASettings class >> projectionsRepositorySettingsOn: aBuilder withConfig: aConfig under: parent populatedWithValuesFrom: aConfigEntry on: app [
	(aBuilder group: #projectionsRepository)
		label: 'Projections Repository' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: aConfig
		under: #projectionsRepository
		populatedWithValuesFrom: aConfigEntry
		on: app
]

{ #category : #settings }
EDASettings class >> resetSettings [
	#(EDACommandStompTopicListener EDAEventStompTopicPublisher EDAMongoEventStore EDALoggingSettings EDAApplication  EDAProjector 	 EDACompositeProjector  EDAProjectionMongoRepository)
		do: [ :cls | cls initialize ]
]

{ #category : #settings }
EDASettings class >> settingOn: aBuilder named: aSymbol labelled: aString withDescription: aDescription usingConfig: aConfig under: aParent on: app [
	| entry |
	(aConfig supportsMultiple: aSymbol)
		ifTrue: [ entry := aBuilder pickOne: aSymbol.
			entry
				domainValues:
					(aConfig availableEnvironments
						collect: [ :level | level translated -> level greaseString ]) ]
		ifFalse: [ (aConfig isReadOnly: aSymbol)
				ifTrue: [ entry := aBuilder group: aSymbol.
					entry dialog: [ LabelMorph newLabel: (aConfig perform: aSymbol) ] ]
				ifFalse: [ entry := aBuilder setting: aSymbol ] ].
	entry
		parent: aParent;
		target: aConfig;
		label: aString translated;
		description: aDescription;
		order: 1
]

{ #category : #settings }
EDASettings class >> stompListenerSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry [
	| stompConfig ack |
	stompConfig := self retrieveSettingAsDict: configEntry.
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'STOMP host' translated;
		description: 'STOMP server host address';
		order: 1;
		default: (stompConfig at: 'host' ifAbsent: 'localhost').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'STOMP port' translated;
		description: 'STOMP server port';
		default: (stompConfig at: 'port' ifAbsent: 61613).
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'STOMP username' translated;
		description: 'STOMP username';
		default: (stompConfig at: 'user' ifAbsent: 'user').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'STOMP password' translated;
		description: 'STOMP password';
		default: (stompConfig at: 'password' ifAbsent: 'secret').
	(aBuilder setting: #queue)
		parent: parent;
		target: container;
		label: 'Queue name' translated;
		description: 'Queue name';
		default: (stompConfig at: 'queue' ifAbsent: 'queue').
	(aBuilder setting: #durable)
		parent: parent;
		target: container;
		label: 'Durable subscription' translated;
		description: 'Durability of subscription';
		default: (stompConfig at: 'durable' ifAbsent: true).
	(stompConfig at: 'ack' ifAbsent: #auto) asSymbol = #auto
		ifTrue:
			[ self logErrorMessage: 'ACK is AUTO. Using client-individual anyway' ].
	ack := #'client-individual'.
	(aBuilder pickOne: #ack)
		parent: parent;
		target: container;
		label: 'Ack policy' translated;
		description: 'Acknowledgement policy';
		domainValues:
			(OrderedCollection
				with: 'Auto' translated -> #auto
				with: 'Client' translated -> #client
				with: 'Client Individual' translated -> #'client-individual');
		default: ack.
	(aBuilder setting: #prefetchCount)
		parent: parent;
		target: container;
		label: 'Prefetch count' translated;
		description: 'Prefetch count';
		default: (stompConfig at: 'prefetchCount' ifAbsent: 1).
	(aBuilder setting: #timeout)
		parent: parent;
		target: container;
		label: 'Timeout' translated;
		description: 'Timeout (in seconds)';
		default: (stompConfig at: 'timeout' ifAbsent: 60).
	(aBuilder setting: #commandListenerClientDebug)
		parent: parent;
		target: container;
		label: 'STOMP client in debug mode' translated;
		description: 'Whether enable debug mode in the STOMP client';
		default: (stompConfig at: 'debug' ifAbsent: true).
	(aBuilder setting: #restartOnCommandConsumingErrors)
		parent: parent;
		target: container;
		label: 'Restart on error' translated;
		description: 'Whether to restart the client in case of errors';
		default: (stompConfig at: 'restartOnError' ifAbsent: false)
]

{ #category : #settings }
EDASettings class >> stompPublisherSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry [
	| stompConfig |
	stompConfig := self retrieveSettingAsDict: configEntry.
	(aBuilder setting: #host)
		parent: parent;
		target: container;
		label: 'STOMP host' translated;
		description: 'STOMP server host address';
		order: 1;
		default: (stompConfig at: 'host' ifAbsent: 'localhost').
	(aBuilder setting: #port)
		parent: parent;
		target: container;
		label: 'STOMP port' translated;
		description: 'STOMP server port';
		default: (stompConfig at: 'port' ifAbsent: 61613).
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'STOMP username' translated;
		description: 'STOMP username';
		default: (stompConfig at: 'user' ifAbsent: 'user').
	(aBuilder setting: #password)
		parent: parent;
		target: container;
		label: 'STOMP password' translated;
		description: 'STOMP password';
		default: (stompConfig at: 'password' ifAbsent: 'secret').
	(aBuilder setting: #exchange)
		parent: parent;
		target: container;
		label: 'Exchange name' translated;
		description: 'Exchange name';
		default: (stompConfig at: 'exchange' ifAbsent: 'exchange').
	(aBuilder setting: #routingKey)
		parent: parent;
		target: container;
		label: 'Routing key';
		description: 'Routing key';
		default: (stompConfig at: 'routingKey' ifAbsent: '#').
	(aBuilder setting: #durable)
		parent: parent;
		target: container;
		label: 'Durable subscription' translated;
		description: 'Durability of subscription';
		default: (stompConfig at: 'durable' ifAbsent: true).
	(aBuilder setting: #timeout)
		parent: parent;
		target: container;
		label: 'Timeout' translated;
		description: 'Timeout (in seconds)';
		default: (stompConfig at: 'timeout' ifAbsent: 60).
	(aBuilder setting: #errorExchange)
		parent: parent;
		target: container;
		label: 'Error exchange' translated;
		description: 'The exchange for errors';
		default: (stompConfig at: 'errorExchange' ifAbsent: 'errors').
	(aBuilder setting: #errorRoutingKey)
		parent: parent;
		target: container;
		label: 'Error routing key';
		description: 'Routing key used for errors';
		default: (stompConfig at: 'errorRoutingKey' ifAbsent: '#')
]
