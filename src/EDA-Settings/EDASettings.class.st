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
		'duEnvironmentClass'
	],
	#category : #'EDA-Settings'
}

{ #category : #settings }
EDASettings class >> commandListenerSettingsOn: aBuilder under: parent [
	| stompConfig values |
	stompConfig := self retrieveSettingAsDict: 'commandListener'.
	values := ((EDAErrorHandlingStrategy allSubclasses sorted: [ :a :b | a priority < b priority ])
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]).
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
		domainValues: values;
		default: (stompConfig at: 'errorStrategy' ifAbsent: [ values first value ]).
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
	| parent |
	parent := EDAApplication subclasses
		ifEmpty: [ nil ]
		ifNotEmpty: [ :c | c first settingsGroup ].
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
	self commandListenerSettingsOn: aBuilder under: #eda.
	self eventListenerSettingsOn: aBuilder under: #eda.
	self eventPublisherSettingsOn: aBuilder under: #eda.
	self eventStoreSettingsOn: aBuilder under: #eda.
	self
		projectionSettingsOn: aBuilder
		under: #eda
		populatedWithValuesFrom: 'projections'.
	self loggingSettingsOn: aBuilder under: #eda
]

{ #category : #settings }
EDASettings class >> eventListenerSettingsOn: aBuilder under: parent [
	(aBuilder group: #eventListener)
		label: 'Event Listener' translated;
		description: 'Event listener';
		parent: parent.
	self
		stompListenerSettingsOn: aBuilder
		withConfig: EDAEventStompTopicListener
		under: #eventListener
		populatedWithValuesFrom: 'eventListener'.
	^ self
]

{ #category : #settings }
EDASettings class >> eventPublisherSettingsOn: aBuilder under: parent [
	(aBuilder group: #eventPublisher)
		label: 'Event Publisher' translated;
		description: 'Event publisher (for integration tests)';
		parent: parent.
	^ self
		stompPublisherSettingsOn: aBuilder
		withConfig: EDAEventStompTopicPublisher
		under: #eventPublisher
		populatedWithValuesFrom: 'eventPublisher'
]

{ #category : #settings }
EDASettings class >> eventStoreSettingsOn: aBuilder under: parent [
	| extSettings |
	extSettings := self retrieveSettingAsDict: 'eventStore'.
	(aBuilder group: #eventStore)
		label: 'Event Store' translated;
		parent: parent.
	^ self
		mongoSettingsOn: aBuilder
		withConfig: EDAMongoEventStore
		under: #eventStore
		populatedWithValuesFrom: extSettings
]

{ #category : #initialization }
EDASettings class >> initialize [
	self duEnvironmentClass: EDADUEnvironment

]

{ #category : #settings }
EDASettings class >> loggingSettingsOn: aBuilder under: parent [
	| extSettings |
	extSettings := self retrieveSettingAsDict: 'logging'.
	(aBuilder group: #logging)
		label: 'Logging' translated;
		parent: parent.
	(aBuilder pickOne: #loggingLevel)
		parent: #logging;
		target: EDALoggingSettings;
		label: 'Logging level' translated;
		description: 'Logging level';
		order: 1;
		domainValues:
			(EDALoggingSettings levels
				collect: [ :level | level translated -> level greaseString ]);
		default: (extSettings at: 'level')
]

{ #category : #settings }
EDASettings class >> mongoSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: mongoConfig [
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
	(aBuilder setting: #username)
		parent: parent;
		target: container;
		label: 'Mongo username' translated;
		description: 'Mongo username';
		default: (mongoConfig at: 'username' ifAbsent: 'user').
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
EDASettings class >> projectionErrorHandlingSettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry [
	(aBuilder group: #errors)
		label: 'Projection errors' translated;
		description: 'Projection error handling';
		noOrdering;
		parent: #projections.
	(aBuilder pickOne: #strategy)
		parent: #errors;
		target: EDAProjectionErrorBehavior;
		label: 'Default projection Error Handling' translated;
		description: 'Default trategy when dealing with errors projecting events';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect: [ :strategy | strategy description -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
	self
		customProjectionErrorBehaviorsOn: aBuilder
		under: #errors
		populatedWithValuesFrom: aConfigEntry
]

{ #category : #settings }
EDASettings class >> projectionSettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry [
	| extSettings |
	extSettings := self retrieveSettingAsDict: aConfigEntry.
	(aBuilder group: #projections)
		label: 'Projections' translated;
		parent: parent.
	self
		projectionsRepositorySettingsOn: aBuilder
		under: #projections
		populatedWithValuesFrom: (extSettings at: 'projectionsRepository' ifAbsent: 'localhost').
	(aBuilder setting: #projectionSynchronizationEnabled)
		parent: #projections;
		target: EDAApplication;
		label: 'Synchronize on startup' translated;
		description:
			'When the EDAApplication starts, this setting enables a check and conditional automatic synchronization of projections';
		default: (extSettings at: 'synchronizationEnabled' ifAbsent: false).
	(aBuilder setting: #concurrentSynchronization)
		parent: #projections;
		target: EDACompositeProjector;
		label: 'Synchronization in parallel' translated;
		description: 'Whether enable or disable concurrent projection synchronization';
		order: 2;
		default: (extSettings at: 'concurrentSynchronization' ifAbsent: false).
	(aBuilder setting: #headlessMode)
		parent: #projections;
		target: EDAProjector;
		label: 'Headless' translated;
		description: 'Whether to show the progress when projecting events visually';
		order: 3;
		default: (extSettings at: 'headlessMode' ifAbsent: false).
	self
		projectionErrorHandlingSettingsOn: aBuilder
		under: parent
		populatedWithValuesFrom: aConfigEntry
]

{ #category : #settings }
EDASettings class >> projectionsRepositorySettingsOn: aBuilder under: parent populatedWithValuesFrom: aConfigEntry [
	(aBuilder group: #projectionsRepository)
		label: 'Projections Repository' translated;
		parent: parent.

	^ self mongoSettingsOn: aBuilder withConfig: EDAProjectionMongoRepository under: #projectionsRepository populatedWithValuesFrom: aConfigEntry

]

{ #category : #settings }
EDASettings class >> resetSettings [
	#(EDACommandStompTopicListener EDAEventStompTopicListener EDAEventStompTopicPublisher EDAMongoEventStore EDALoggingSettings EDAApplication EDAProjector EDACompositeProjector EDAProjectionMongoRepository)
		do: [ :cls | cls initialize ]
]

{ #category : #settings }
EDASettings class >> stompListenerSettingsOn: aBuilder withConfig: container under: parent populatedWithValuesFrom: configEntry [
	| stompConfig ack |
	stompConfig := self retrieveSettingAsDict: configEntry.
	(aBuilder pickOne: #strategy)
		parent: parent;
		target: container;
		label: 'Error strategy' translated;
		description: 'Strategy when dealing with command consuming errors';
		order: 1;
		domainValues:
			(EDAErrorHandlingStrategy subclasses
				collect:
					[ :strategy | strategy description translated -> strategy greaseString ]);
		default: EDAPublishMessageErrorStrategy greaseString.
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
		target: EDAApplication;
		label: 'STOMP client in debug mode' translated;
		description: 'Whether enable debug mode in the STOMP client';
		default: (stompConfig at: 'debug' ifAbsent: true).
	(aBuilder setting: #restartOnCommandConsumingErrors)
		parent: parent;
		target: EDAMessageConsumer;
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
