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
	#classVars : [
		'ProjectionSynchronizationEnabled'
	],
	#classInstVars : [
		'eventStore',
		'eventAnnouncer',
		'commandConsumer',
		'commandDispatcher',
		'eventProducer',
		'commandListenerClientDebug',
		'isConfigured',
		'isStarted',
		'projectors',
		'projectorsByTenant',
		'tenants'
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
EDAApplication class >> commandConsumer [
	^ commandConsumer
]

{ #category : #accessing }
EDAApplication class >> commandConsumer: anObject [
	commandConsumer := anObject
]

{ #category : #accessing }
EDAApplication class >> commandDispatcher [
	^ commandDispatcher
]

{ #category : #accessing }
EDAApplication class >> commandDispatcher: anObject [
	commandDispatcher := anObject
]

{ #category : #accessing }
EDAApplication class >> commandListenerClientDebug [
	^ commandListenerClientDebug
]

{ #category : #accessing }
EDAApplication class >> commandListenerClientDebug: aBoolean [
	commandListenerClientDebug := aBoolean
]

{ #category : #'configuration building' }
EDAApplication class >> configFromEnvironmentIsNecessary [
	| nonNecessaryConfigCreationEnvironments |
	nonNecessaryConfigCreationEnvironments :=
		OrderedCollection
			with: 'development'
			with: 'integration-tests'
			with: 'prueba_mails_DEMO'
			with: 'prueba_mails_PRO'.
	^ (nonNecessaryConfigCreationEnvironments anySatisfy: [ :env | env = EDADUEnvironment currentEnvironment ]) not
]

{ #category : #'configuration building' }
EDAApplication class >> configFromEnvironmentVars [
	"Create a config/XXX.json if neccesary placing environment vars values to config/dynamic.json"

	""

	| envVarNotFoundsMessage newDynamicConfigText configJsonText configFile imageDirectoryPath dinamicJsonPath |
	self configFromEnvironmentIsNecessary
		ifFalse: [ ^ self ].
	envVarNotFoundsMessage := WriteStream on: String new.
	imageDirectoryPath := SmalltalkImage current imageDirectory absolutePath.
	self logInfoMessage: 'Image path: ' , imageDirectoryPath greaseString.
	dinamicJsonPath := imageDirectoryPath / 'config/dynamic.json'.
	self logInfoMessage: 'Dynamic json path: ' , dinamicJsonPath greaseString.
	newDynamicConfigText := dinamicJsonPath asFileReference
		contents asString deepCopy.
	configJsonText := '\"\|([^|]*)\|\"' asRegex
		copy: newDynamicConfigText
		translatingMatchesUsing: [ :match | 
			| envVar value |
			envVar := (match onlyLetters
				copyWithRegex: '[A-Z]'
				matchesTranslatedUsing: [ :each | '_' , each asLowercase ])
				asUppercase.
			value := OSProcess thisOSProcess environment
				at: envVar
				ifAbsent: [ envVarNotFoundsMessage
						nextPutAll: 'Missing environment variable: ';
						nextPutAll: envVar;
						nextPutAll: ' . '.
					'' ].
			self configValueFromEnvVarValue: value ].
	envVarNotFoundsMessage close.
	envVarNotFoundsMessage contents
		ifNotEmpty: [ :errorMessage | 
			self
				logErrorMessage: errorMessage
				andThrow: EDAMissingEnvironmentVariables ].
	configFile := ('./config/' , EDADUEnvironment currentEnvironment
		, '.json') asFileReference.
	configFile exists
		ifFalse: [ configFile createFile ].
	configFile
		writeStreamDo: [ :s | 
			s truncate.
			s nextPutAll: configJsonText ].
	self
		logDebugMessage: 'Created ' , configFile greaseString , ' with ' , configFile contents.
]

{ #category : #'configuration building' }
EDAApplication class >> configValueFromEnvVarValue: value [
	(self mustNotBeStringOnJsonAValue: value)
		ifTrue: [ ^ value greaseString ].
	^ '"' , value , '"'
]

{ #category : #'setup - events' }
EDAApplication class >> configureEventStoreAuthentication [
		EDAMongoEventStore authenticationMechanism beDefault
]

{ #category : #'setup - projections' }
EDAApplication class >> configureProjectionBackendAuthentication: anObject [
	anObject configureAuthentication
]

{ #category : #'setup - events' }
EDAApplication class >> createEventProducer: anEventProducerClass [
	^ anEventProducerClass withEventAnnouncer: eventAnnouncer
	
]

{ #category : #'setup - events' }
EDAApplication class >> createEventProducerPublishing: anEventProducerClass [
	^ anEventProducerClass withEventAnnouncer: eventAnnouncer publisher: EDAEventStompTopicPublisher new andSerializer: EDAJsonEventSerializer new
]

{ #category : #'class initialization' }
EDAApplication class >> doInitialize [
	self isStarted: false.
	self isConfigured: false.
	self projectorsByTenant: Dictionary new.
	tenants := Set empty
]

{ #category : #setup }
EDAApplication class >> doSetup [
	self configFromEnvironmentVars.
	EDASettings withAllSubclassesDo: [ :settingsClass | settingsClass resetSettings ].
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
EDAApplication class >> eventAnnouncer [
	^ eventAnnouncer
]

{ #category : #accessing }
EDAApplication class >> eventAnnouncer: anObject [
	eventAnnouncer := anObject
]

{ #category : #accessing }
EDAApplication class >> eventProducer [
	^ eventProducer
]

{ #category : #accessing }
EDAApplication class >> eventProducer: anObject [
	eventProducer := anObject
]

{ #category : #accessing }
EDAApplication class >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAApplication class >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #'class initialization' }
EDAApplication class >> initialize [
	self doInitialize
]

{ #category : #accessing }
EDAApplication class >> isConfigured [
	^ isConfigured
]

{ #category : #accessing }
EDAApplication class >> isConfigured: aBoolean [
	isConfigured := aBoolean
]

{ #category : #accessing }
EDAApplication class >> isStarted [
	^ isStarted
]

{ #category : #accessing }
EDAApplication class >> isStarted: aBoolean [
	isStarted := aBoolean
]

{ #category : #logging }
EDAApplication class >> logSettings [
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

{ #category : #'configuration building' }
EDAApplication class >> mustNotBeStringOnJsonAValue: value [
	"Values are always string but on config json integers and booleans must be represented without double quotes characteres (no strings)"
	"Regex for value starting with 0 must be string"
	^ (value matchesRegex: '^([1-9])\d+$')
		or: [ (OrderedCollection with: 'true' with: 'false')
				anySatisfy: [ :booleanString | booleanString = value ] ]
]

{ #category : #accessing }
EDAApplication class >> projectionSynchronizationEnabled [
	^ ProjectionSynchronizationEnabled
]

{ #category : #accessing }
EDAApplication class >> projectionSynchronizationEnabled: aBoolean [
	ProjectionSynchronizationEnabled := aBoolean
]

{ #category : #accessing }
EDAApplication class >> projectorsByTenant [
	| result |
	result := projectorsByTenant.
	result ifNil: [ result := Dictionary new. projectorsByTenant := result ].
	^ result
]

{ #category : #accessing }
EDAApplication class >> projectorsByTenant: aDictionary [
	projectorsByTenant := aDictionary
]

{ #category : #'setup - projections' }
EDAApplication class >> removeAllProjections [
	self
		logInfoMessage: 'Removing all projections'.
	EDAProjection removeAllProjections
]

{ #category : #reset }
EDAApplication class >> reset [
	self resetEventSubscriptions.
	self resetCommandConsumer.
	self resetCommandDispatcher.
	self resetProjectors.
	self resetProjections.
	self resetRepositories.
	self resetEventStore.
	self resetEventProducer.
	self resetEventAnnouncer.
	self resetTenants.
	self resetLogging.
	self isConfigured: false
]

{ #category : #'reset - commands' }
EDAApplication class >> resetCommandConsumer [
	self commandConsumer ifNotNil: [ :c | c close ].
	self commandConsumer: nil
]

{ #category : #'reset - commands' }
EDAApplication class >> resetCommandDispatcher [
	self commandDispatcher: nil
]

{ #category : #'reset - events' }
EDAApplication class >> resetEventAnnouncer [
	eventAnnouncer := nil
]

{ #category : #'reset - events' }
EDAApplication class >> resetEventProducer [
	self eventProducer ifNotNil: [ :producer | producer close ].
	self eventProducer: nil
]

{ #category : #'reset - events' }
EDAApplication class >> resetEventStore [
	self eventStore: nil
]

{ #category : #'reset - events' }
EDAApplication class >> resetEventSubscriptions [
	self subclassResponsibility
]

{ #category : #reset }
EDAApplication class >> resetLogging [
	EDALogEvent announcer
		unsubscribe: EDALogEvent
]

{ #category : #'reset - projections' }
EDAApplication class >> resetProjections [
	"nothing to do"
	
]

{ #category : #'reset - projections' }
EDAApplication class >> resetProjectorOfTenant: aTenant [
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector
		ifNotNil: [ :p | p class synchronizationInProgressOfTenant: aTenant is: false .
	self projectorsByTenant removeKey: aTenant ]
]

{ #category : #'reset - projections' }
EDAApplication class >> resetProjectors [
	self retrieveAllTenants do: [ :t | self resetProjectorOfTenant: t ].
	self projectorsByTenant: Dictionary empty
]

{ #category : #'reset - repositories' }
EDAApplication class >> resetRepositories [
	EDAAggregateRepository allSubclassesDo: [ :repo | repo eventStore: nil ]
]

{ #category : #'reset - commands' }
EDAApplication class >> resetTenants [
	tenants := Set empty
]

{ #category : #'multitenancy support' }
EDAApplication class >> retrieveAllTenants [
	self shouldBeImplemented
]

{ #category : #setup }
EDAApplication class >> setup [
	self isConfigured ifNil: [ self isConfigured: false ].
	self isConfigured ifTrue: [ ^ self ].
	self doSetup.
	self isConfigured: true
]

{ #category : #'setup - commands' }
EDAApplication class >> setupCommandConsumer [
	^ self setupCommandConsumerWithCommandListener: EDACommandStompTopicListener new
]

{ #category : #'setup - commands' }
EDAApplication class >> setupCommandConsumerWithCommandListener: listener [
	| materializer |
	listener client debug: self commandListenerClientDebug.
	materializer := EDAJsonCommandMaterializer new.
	self
		commandConsumer: (EDACommandConsumer busListener: listener commandMaterializer: materializer commandDispatcher: self commandDispatcher)
]

{ #category : #setup }
EDAApplication class >> setupCommandDispatcher [
	self
		commandDispatcher:
			(self
				buildCommandDispatcherWithEventStore: self eventStore
				eventProducer: self eventProducer
				andProjectorClass: EDACompositeProjector)
]

{ #category : #'setup - events' }
EDAApplication class >> setupEventAnnouncer [
	self eventAnnouncer: Announcer new
]

{ #category : #'setup - events' }
EDAApplication class >> setupEventProducer [
	eventProducer := EDAEventProducerBehavior eventProducerForEDAApplication: self
]

{ #category : #'setup - events' }
EDAApplication class >> setupEventStore [
	self flag: #TODO.	"Find out how to customize the authentication of the specific Mongo instance"
	self eventStore: EDAMongoEventStore new.
	self configureEventStoreAuthentication
]

{ #category : #'setup - events' }
EDAApplication class >> setupEventSubscriptions [
	"Use self announcer
	e.g. self announcer when: EventClass do: [  ] "

	[ self subclassResponsibility ]
		on: Error
		do: [ :e | self ]
]

{ #category : #setup }
EDAApplication class >> setupLogging [
	EDALogEvent announcer
		when: EDALogEvent
		do: [ :event | self logInfoMessage: event greaseString ]
]

{ #category : #'setup - projections' }
EDAApplication class >> setupProjectionRepositoryForProjection: aProjectionClass [
	| repository |
	repository := EDAProjectionMongoRepository new.
	self configureProjectionBackendAuthentication: repository.
	aProjectionClass repository: repository
]

{ #category : #'setup - projections' }
EDAApplication class >> setupProjections [
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
EDAApplication class >> setupProjectorOfTenant: aTenant [
	self
		projectorsByTenant at: aTenant put:
			(EDACompositeProjector
				ofTenant: aTenant
				withAllProjectorsAndEventStore: self eventStore)
]

{ #category : #'setup - projections' }
EDAApplication class >> setupProjectors [
	self retrieveAllTenants do: [ :tenant | self setupProjectorOfTenant: tenant ]
]

{ #category : #'setup - repositories' }
EDAApplication class >> setupRepositories [
	EDAAggregateRepository
		allSubclassesDo: [ :repo | repo setupEventStore: self eventStore ].
	EDAEventSourcingEvent voyageRepository: self eventStore repository.
	EDAEventSourcingEvent
		allSubclassesDo: [ :event | event voyageRepository: self eventStore repository ]
]

{ #category : #api }
EDAApplication class >> start [
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
EDAApplication class >> stop [
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifFalse: [ ^ self ].
	self commandConsumer ifNotNil: [ :arg | arg stop ].
	self isStarted: false.
	self logInfoMessage: self applicationName , ' stopped'
]

{ #category : #'setup - projections' }
EDAApplication class >> synchronizeProjections [
	self removeAllProjections.
	self retrieveAllTenants
		do: [ :tenant | 
			| projector |
			projector := self projectorsByTenant at: tenant ifAbsent: [ nil ].
			projector ifNotNil: [ :p | p projectOfTenant: tenant ] ]
]

{ #category : #'setup - projections' }
EDAApplication class >> synchronizeProjectionsOfTenant: aTenant [
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector ifNotNil: [ :p | p projectOfTenant: aTenant ]
]
