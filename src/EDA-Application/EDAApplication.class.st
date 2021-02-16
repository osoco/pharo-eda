"
Class:
I'm the parent class for EDA-based applications.

Responsibilities: 
- I'm in charge of bootstrapping the EDA application.
- I configure the EventStore, the repositories, the projections, the STOMP clients.

Collaborators:
- I use Pharo Settings to know how to access the event store, the projections, the STOMP queues and exchanges.
- I can send Announcements.

Public API and Key Messages

- EDAApplication class >> setup : Bootstraps and sets up the adapters for the Event Store, Projections, STOMP clients.
- EDAApplication class >> start: Starts accepting incoming commands.
- EDAApplication class >> stop: To stop accepting incoming commands.
- EDAApplications are not designed to be instantiated.

Internal Representation and Key Implementation Points.

- There're some settings mapped to EDAApplication. 
"
Class {
	#name : #EDAApplication,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'commandConsumer',
		'commandDispatcher',
		'eventAnnouncer',
		'eventProducer',
		'eventStore',
		'isConfigured',
		'isStarted',
		'projectorsByTenant',
		'applicationName',
		'portSettingsPort',
		'environmentSettingsPort',
		'environmentSettingsResolverPort',
		'settingsAnnouncer',
		'settingsSubscriber',
		'eventStoreSettingsPort'
	],
	#classVars : [
		'ProjectionSynchronizationEnabled'
	],
	#category : #'EDA-Application'
}

{ #category : #accessing }
EDAApplication class >> applicationName [
	self subclassResponsibility
]

{ #category : #setup }
EDAApplication class >> buildCommandDispatcherWithEventStore: anEventStore eventProducer: anEventProducer andProjectorClass: aClass [
	| handlerScanner handlerFactory commandRegistry |
	handlerScanner := EDAPragmaCommandHandlerMethodsScanner
		scannerPragma: #useAsCommandHandlerFor:
		from: EDAAggregateRoot.
	handlerFactory := EDACommandHandlerFactory
		factoryWithEventStore: anEventStore
		eventBus: anEventProducer.
	commandRegistry := EDACommandHandlersRegistry
		withScanner: handlerScanner
		factory: handlerFactory
		andProjectorClass: aClass.
	^ EDACommandDispatcher
		withRegistry: commandRegistry
		eventStore: anEventStore
		eventProducer: anEventProducer
		andProjectorClass: aClass
]

{ #category : #accessing }
EDAApplication class >> defaultEnvironment [
	^ EDADUEnvironment new
]

{ #category : #'instance creation' }
EDAApplication class >> new [
	MessageNotUnderstood
		signal: 'Use ' , self class printString , '>>withName: or ' , self class printString , '>>unnamed instead'
]

{ #category : #'instance creation' }
EDAApplication class >> unnamed [
	^ self withName: self applicationName

]

{ #category : #'instance creation' }
EDAApplication class >> withName: anApplicationName [
	| result |
	(EDAApplications uniqueInstance edaApplications
		select: [ :app | app applicationName = anApplicationName ])
		ifEmpty: [ result := self basicNew initialize.
			result applicationName: anApplicationName.
			EDAApplications uniqueInstance register: result ]
		ifNotEmpty: [ :c | result := c first ].
	^ result
]

{ #category : #accessing }
EDAApplication >> applicationName [
	^ applicationName ifNil: [ self class applicationName ]
]

{ #category : #accessing }
EDAApplication >> applicationName: aString [
	applicationName := aString
]

{ #category : #accessing }
EDAApplication >> commandConsumer [
	^ commandConsumer
]

{ #category : #accessing }
EDAApplication >> commandConsumer: anObject [
	commandConsumer := anObject
]

{ #category : #accessing }
EDAApplication >> commandDispatcher [
	^ commandDispatcher
]

{ #category : #accessing }
EDAApplication >> commandDispatcher: anObject [
	commandDispatcher := anObject
]

{ #category : #accessing }
EDAApplication >> commandListenerSettingsPort [
	^ self resolveCommandListenerSettingsPort
]

{ #category : #'setup - events' }
EDAApplication >> configureEventStoreAuthentication [
		EDAMongoEventStore authenticationMechanism beDefault
]

{ #category : #'setup - projections' }
EDAApplication >> configureProjectionBackendAuthentication: anObject [
	anObject configureAuthentication
]

{ #category : #'class initialization' }
EDAApplication >> doInitialize [
	self isStarted: false.
	self isConfigured: false.
	self resetPortSettingsPort.
	self projectorsByTenant: Dictionary new.
	self setupSettingsAnnouncer.
	self setupEventAnnouncer.
	self setupSettingsSubscriptions 
]

{ #category : #setup }
EDAApplication >> doSetup [
	SettingBrowser open delete.
	self setupLogging.
	self setupEventAnnouncer.
	self setupEventProducer.
	self setupEventStore.
	self setupRepositories.
	self setupProjections.
	self setupProjectors.
	self projectionSynchronizationEnabled
		ifTrue: [ self synchronizeProjections ].
	self setupCommandDispatcher.
	self setupCommandConsumer.
	self setupEventSubscriptions
]

{ #category : #accessing }
EDAApplication >> environmentSettingsPort [
	^ self portSettingsPort environmentSettingsPort
]

{ #category : #accessing }
EDAApplication >> environmentSettingsPort: anAdapter [
	anAdapter = self portSettingsPort environmentSettingsPort
		ifTrue: [ ^ self ].
	self portSettingsPort environmentSettingsPort: anAdapter.
	self notifyEnvironmentSettingsPortListener: anAdapter
]

{ #category : #accessing }
EDAApplication >> eventAnnouncer [
	^ eventAnnouncer
]

{ #category : #accessing }
EDAApplication >> eventAnnouncer: anObject [
	eventAnnouncer := anObject
]

{ #category : #accessing }
EDAApplication >> eventProducer [
	^ eventProducer
]

{ #category : #accessing }
EDAApplication >> eventProducer: anObject [
	eventProducer := anObject
]

{ #category : #accessing }
EDAApplication >> eventPublisherSettingsPort [
	^ self resolveEventPublisherSettingsPort
]

{ #category : #accessing }
EDAApplication >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAApplication >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #accessing }
EDAApplication >> eventStoreSettingsPort [
		^ self portSettingsPort eventStoreSettingsPort
]

{ #category : #accessing }
EDAApplication >> eventStoreSettingsPort: anAdapter [
	anAdapter = self portSettingsPort eventStoreSettingsPort
		ifTrue: [ ^ self ].
	self portSettingsPort eventStoreSettingsPort: anAdapter.
	self notifyEventStoreSettingsPortListener: anAdapter
]

{ #category : #'class initialization' }
EDAApplication >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #accessing }
EDAApplication >> isConfigured [
	^ isConfigured
]

{ #category : #accessing }
EDAApplication >> isConfigured: aBoolean [
	isConfigured := aBoolean
]

{ #category : #accessing }
EDAApplication >> isStarted [
	^ isStarted
]

{ #category : #accessing }
EDAApplication >> isStarted: aBoolean [
	isStarted := aBoolean
]

{ #category : #logging }
EDAApplication >> logSettings [
	self
		logDebugMessage: 'Command consumer: ' , self commandConsumer greaseString.
	self
		logDebugMessage: 'Command dispatcher: ' , self commandDispatcher greaseString.
	self
		logDebugMessage:
			'Command listener client debug: '
				, self commandListenerClientDebug greaseString.
	self
		logDebugMessage: 'Event announcer: ' , self eventAnnouncer greaseString.
	self
		logDebugMessage: 'Event producer: ' , self eventProducer greaseString.
	self logDebugMessage: 'Event store: ' , self eventStore greaseString.
	self
		logDebugMessage:
			'Projection synchronization enabled: '
				, self projectionSynchronizationEnabled greaseString.
	self
		logDebugMessage: 'Projectors: ' , self projectorsByTenant greaseString
]

{ #category : #accessing }
EDAApplication >> loggingSettingsPort [
	^ self resolveLoggingSettingsPort
]

{ #category : #accessing }
EDAApplication >> notifyEnvironmentSettingsPortListener: anAdapter [
	self settingsAnnouncer
		announce: (EDAEnvironmentSettingsPortChanged with: anAdapter on: self)
]

{ #category : #accessing }
EDAApplication >> notifyEnvironmentSettingsResolverPortListener: anAdapter [
	self settingsAnnouncer
		announce: (EDAEnvironmentSettingsResolverPortChanged with: anAdapter on: self)
]

{ #category : #accessing }
EDAApplication >> notifyEventStoreSettingsPortListener: anAdapter [
	self settingsAnnouncer
		announce: (EDAEventStoreSettingsPortChanged with: anAdapter on: self)
]

{ #category : #accessing }
EDAApplication >> notifyEventStoreSettingsResolverPortListener: anAdapter [
	self settingsAnnouncer
		announce: (EDAEventStoreSettingsResolverPortChanged with: anAdapter on: self)
]

{ #category : #accessing }
EDAApplication >> portSettingsPort [
	^ portSettingsPort
		ifNil: [ | result |
			result := EDAPortResolverInMemoryAdapter withApp: self.
			result ]
]

{ #category : #accessing }
EDAApplication >> portSettingsPort: anAdapter [
	portSettingsPort := anAdapter
]

{ #category : #accessing }
EDAApplication >> projectionSettingsPort [
	^ self resolveProjectionSettingsPort
]

{ #category : #accessing }
EDAApplication >> projectionSynchronizationEnabled [
	^ ProjectionSynchronizationEnabled
]

{ #category : #accessing }
EDAApplication >> projectionSynchronizationEnabled: aBoolean [
	ProjectionSynchronizationEnabled := aBoolean
]

{ #category : #accessing }
EDAApplication >> projectorsByTenant [
	| result |
	result := projectorsByTenant.
	result
		ifNil: [ result := Dictionary new.
			self projectorsByTenant: result ].
	^ result
]

{ #category : #accessing }
EDAApplication >> projectorsByTenant: aDictionary [
	projectorsByTenant := aDictionary
]

{ #category : #reset }
EDAApplication >> reset [
	self resetPortResolver.
	self resetLogging.
	self resetEventProducer.
	self resetEventStore.
	self resetRepositories.
	self resetProjections.
	self resetProjectors.
	self resetCommandDispatcher.
	self resetCommandConsumer.
	self resetEventSubscriptions.
	self resetEventAnnouncer.
	self resetSettingsAnnouncer.
	self isConfigured: false
]

{ #category : #'reset - commands' }
EDAApplication >> resetCommandConsumer [
	self commandConsumer ifNotNil: [ :c | c close ].
	self commandConsumer: nil
]

{ #category : #'reset - commands' }
EDAApplication >> resetCommandDispatcher [
	self commandDispatcher: nil
]

{ #category : #'reset - events' }
EDAApplication >> resetEventAnnouncer [
	self eventAnnouncer: nil
]

{ #category : #'reset - events' }
EDAApplication >> resetEventProducer [
	self eventProducer ifNotNil: [ :producer | producer close ].
	self eventProducer: nil
]

{ #category : #'reset - events' }
EDAApplication >> resetEventStore [
	self eventStore: nil
]

{ #category : #'reset - events' }
EDAApplication >> resetEventSubscriptions [
	self subclassResponsibility
]

{ #category : #reset }
EDAApplication >> resetLogging [
	EDALogEvent announcer
		unsubscribe: EDALogEvent
]

{ #category : #reset }
EDAApplication >> resetPortSettingsPort [
	self portSettingsPort: (EDAPortResolverInMemoryAdapter withApp: self).
]

{ #category : #'reset - projections' }
EDAApplication >> resetProjections [
	"nothing to do"
	
]

{ #category : #'reset - projections' }
EDAApplication >> resetProjectorOfTenant: aTenant [
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector
		ifNotNil: [ :p | p class synchronizationInProgressOfTenant: aTenant is: false .
	self projectorsByTenant removeKey: aTenant ]
]

{ #category : #'reset - projections' }
EDAApplication >> resetProjectors [
	self retrieveAllTenants do: [ :t | self resetProjectorOfTenant: t ]


]

{ #category : #'reset - repositories' }
EDAApplication >> resetRepositories [
	EDAAggregateRepository allSubclassesDo: [ :repo | repo eventStore: nil ]
]

{ #category : #'reset - events' }
EDAApplication >> resetSettingsAnnouncer [
	self settingsAnnouncer: nil
]

{ #category : #accessing }
EDAApplication >> resolveCommandListenerSettingsPort [
	^ self resolveSettingsPort: EDATCommandListenerSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveEnvironmentSettingsPort [
	^ self resolveSettingsPort: EDATEnvironmentSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveEventPublisherSettingsPort [
	^ self resolveSettingsPort: EDATEventPublisherSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveEventStoreSettingsPort [
	^ self resolveSettingsPort: EDATEventStoreSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveLoggingSettingsPort [
	^ self resolveSettingsPort: EDATLoggingSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveProjectionSettingsPort [
	^ self resolveSettingsPort: EDATProjectionSettingsPort
]

{ #category : #accessing }
EDAApplication >> resolveSettingsPort: aPort [
	| candidates candidate |
	candidates := (aPort traitUsers select: [ :cls | cls accepts: self ])
		sorted.
	candidate := candidates ifEmpty: [ nil ] ifNotEmpty: [ :col | col first ].
	^ candidate ifNil: [ nil ] ifNotNil: [ :c | c withApp: self ]
]

{ #category : #'multitenancy support' }
EDAApplication >> retrieveAllTenants [
	self shouldBeImplemented
]

{ #category : #accessing }
EDAApplication >> settingsAnnouncer [
	settingsAnnouncer
		ifNil: [ self settingsAnnouncer: Announcer new ].
	^ settingsAnnouncer
]

{ #category : #accessing }
EDAApplication >> settingsAnnouncer: anAnnouncer [
	settingsAnnouncer := anAnnouncer 
]

{ #category : #accessing }
EDAApplication >> settingsSubscriber [
	settingsSubscriber ifNil: [ self settingsSubscriber: EDASettingsSubscriber new ].
	^ settingsSubscriber 
]

{ #category : #accessing }
EDAApplication >> settingsSubscriber: aSubscriber [
	settingsSubscriber := aSubscriber
]

{ #category : #setup }
EDAApplication >> setup [
	self isConfigured ifNil: [ self isConfigured: false ].
	self isConfigured ifTrue: [ ^ self ].
	self doSetup.
	self isConfigured: true
]

{ #category : #'setup - commands' }
EDAApplication >> setupCommandConsumer [
	^ self setupCommandConsumerWithCommandListener: EDACommandStompTopicListener new
]

{ #category : #'setup - commands' }
EDAApplication >> setupCommandConsumerWithCommandListener: listener [
	| materializer |
	listener client debug: self commandListenerClientDebug.
	materializer := EDAJsonCommandMaterializer new.
	self
		commandConsumer: (EDACommandConsumer busListener: listener commandMaterializer: materializer commandDispatcher: self commandDispatcher)
]

{ #category : #setup }
EDAApplication >> setupCommandDispatcher [
	| handlerScanner  handlerFactory commandRegistry |
	EDADeleteCommandHandler eventStore: self eventStore; eventBus: self eventProducer.
	handlerScanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #useAsCommandHandlerFor: from: EDAAggregateRoot.
	handlerFactory := EDACommandHandlerFactory factoryWithEventStore: self eventStore eventBus: self eventProducer.
	commandRegistry := EDACommandHandlersRegistry withScanner: handlerScanner factory: handlerFactory.
	self commandDispatcher: (EDACommandDispatcher withRegistry: commandRegistry).
]

{ #category : #'setup - events' }
EDAApplication >> setupEventAnnouncer [
	self eventAnnouncer: Announcer new
]

{ #category : #'setup - events' }
EDAApplication >> setupEventProducer [
	| eventPublisher eventSerializer |
	eventPublisher := EDAEventStompTopicPublisher new.
	eventSerializer := EDAJsonEventSerializer new.
	self eventProducer: (EDAEventProducer publisher: eventPublisher serializer: eventSerializer announcer: self eventAnnouncer)
]

{ #category : #'setup - events' }
EDAApplication >> setupEventStore [
	self flag: #TODO.	"Find out how to customize the authentication of the specific Mongo instance"
	self eventStore: EDAMongoEventStore new.
	self configureEventStoreAuthentication
]

{ #category : #'setup - events' }
EDAApplication >> setupEventSubscriptions [
	self subclassResponsibility 
]

{ #category : #setup }
EDAApplication >> setupLogging [
	EDALogEvent announcer
		when: EDALogEvent
		do: [ :event | self logInfoMessage: event greaseString ]
]

{ #category : #'setup - projections' }
EDAApplication >> setupProjectionRepositoryForProjection: aProjectionClass [
	| repository |
	repository := EDAProjectionMongoRepository new.
	self configureProjectionBackendAuthentication: repository.
	aProjectionClass repository: repository
]

{ #category : #'setup - projections' }
EDAApplication >> setupProjections [
	| projectionClasses |
	projectionClasses := EDAProjection allSubclasses
		reject: [ :projectionClass | 
			(projectionClass name beginsWithSubCollection: 'EDATest')
				or: [ projectionClass isAbstract ] ].
	projectionClasses add: EDAProjection.
	projectionClasses
		do:
			[ :projectionClass | 
			self setupProjectionRepositoryForProjection: projectionClass ]
]

{ #category : #'setup - projections' }
EDAApplication >> setupProjectorOfTenant: aTenant [
	self
		projectorsByTenant at: aTenant put:
			(EDACompositeProjector
				ofTenant: aTenant
				withAllProjectorsAndEventStore: self eventStore)
]

{ #category : #'setup - projections' }
EDAApplication >> setupProjectors [
	self retrieveAllTenants do: [ :tenant | self setupProjectorOfTenant: tenant ]
]

{ #category : #'setup - repositories' }
EDAApplication >> setupRepositories [
	EDAAggregateRepository
		allSubclassesDo: [ :repo | repo setupEventStore: self eventStore ].
	EDAEventSourcingEvent voyageRepository: self eventStore repository.
	EDAEventSourcingEvent
		allSubclassesDo: [ :event | event voyageRepository: self eventStore repository ]
]

{ #category : #'setup - events' }
EDAApplication >> setupSettingsAnnouncer [
	self settingsAnnouncer: Announcer new
]

{ #category : #'setup - events' }
EDAApplication >> setupSettingsSubscriptions [
	self settingsSubscriber
		setupAnnouncer: self settingsAnnouncer
		application: self
]

{ #category : #api }
EDAApplication >> start [
	self setup.
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifTrue: [ ^ self ].
	self commandConsumer
		ifNotNil: [ :c | 
			c start.
			self isStarted: true ].
	self logInfoMessage: self applicationName , ' started'
]

{ #category : #api }
EDAApplication >> stop [
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifFalse: [ ^ self ].
	self commandConsumer ifNotNil: [ :arg | arg stop ].
	self isStarted: false.
	self logInfoMessage: self applicationName , ' stopped'
]

{ #category : #'setup - projections' }
EDAApplication >> synchronizeProjections [
	self retrieveAllTenants
		do: [ :tenant |
			| projector |
			projector := self projectorsByTenant at: tenant ifAbsent: [ nil ].
			projector ifNotNil: [ :p | p projectOfTenant: tenant ] ]
]

{ #category : #'setup - projections' }
EDAApplication >> synchronizeProjectionsOfTenant: aTenant [
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector ifNotNil: [ :p | p projectOfTenant: aTenant ]
]
