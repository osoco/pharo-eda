"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State the name of the class with one line description: For example, I'm EDATIntegrationTestBDD the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points

"
Trait {
	#name : #EDATIntegrationTestBDD,
	#traits : 'EDATJsonMatchingHelper + EDACLogging',
	#classTraits : 'EDATJsonMatchingHelper classTrait + EDACLogging classTrait',
	#category : #'EDA-Commands-Tests'
}

{ #category : #logging }
EDATIntegrationTestBDD classSide >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATIntegrationTestBDD classSide >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATIntegrationTestBDD classSide >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATIntegrationTestBDD classSide >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATIntegrationTestBDD classSide >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #accessing }
EDATIntegrationTestBDD >> application [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #accessing }
EDATIntegrationTestBDD >> application: app [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #helper }
EDATIntegrationTestBDD >> assertEvent: eventMessage matchesEventRegex: eventMessageRegex [
	^ self assertJson: eventMessage matchesRegex: eventMessageRegex
]

{ #category : #bdd }
EDATIntegrationTestBDD >> assertEventMessagesMatch: expectedEventMessages withRoutingKeys: expectedRoutingKeys [
	| anyEventGenerated |
	[
		anyEventGenerated := false.
		expectedEventMessages	doWithIndex: [ :eventMessageRegex :index |
			| frame |
			frame := self assertNextReceivedEventMessage: self eventListener matches: eventMessageRegex.
			frame ifNotNil: [
				anyEventGenerated := true.
				expectedRoutingKeys size >= index
					ifTrue: [ self assert: (self routingKeyFromDestination: frame destination) equals: (expectedRoutingKeys at: index) ]
			]
		]
	]
	on: ConnectionTimedOut
	do: [ :ex |
		anyEventGenerated
			ifTrue: [ self fail: 'At least one of the generated events do not match the expected regular expression' ]
			ifFalse: [ self fail: 'No events generated' ]
	]
]

{ #category : #bdd }
EDATIntegrationTestBDD >> assertGeneratedEvent: frame matchesRegex: eventMessageRegex [
	| command body |
	command := frame command.
	body := frame body.
	self assert: command equals: #MESSAGE.
	self assertEvent: body matchesEventRegex: eventMessageRegex
]

{ #category : #asserting }
EDATIntegrationTestBDD >> assertNextReceivedEventMessage: stompListener matches: eventMessageRegex [
	| frame ack nack |
	self logInfoMessage: 'Waiting for incoming messages...'.
	[ frame := stompListener client readMessage.
	ack := frame ackFrame.
	nack := frame nackFrame.
	stompListener client write: ack.
	self logDebugMessage: 'Received event: ' , frame body greaseString.
	self assertGeneratedEvent: frame matchesRegex: eventMessageRegex.
	^ frame ]
		on: Error
		do: [ :ex |
			self logErrorMessage: 'Error consuming message: ' , ex description greaseString.
			self fail: 'Error consuming message: ', ex description greaseString.
			"nack ifNotNil: [ :arg |
			arg headers at: 'requeue' put: 'False'.
			stompListener client writeWithReceipt: arg.
			self unsubscribeToEvents
		]."
			^ frame ]
]

{ #category : #helper }
EDATIntegrationTestBDD >> buildEventSerializer [
	^ EDAJsonEventSerializer new
]

{ #category : #bdd }
EDATIntegrationTestBDD >> checkNewStoredEvents: expectedNewStoredEvents ofTenant: aTenant givenPreviousEvents: previousEventsCollection [
	| storedEvents allEvents expectedStoredEvents |
	expectedNewStoredEvents
		ifNotNil: [ :events |
			storedEvents := self application eventStore allEventsOfTenant: aTenant.
			expectedStoredEvents := OrderedCollection
				newFrom: previousEventsCollection.
			expectedStoredEvents addAll: events.
			self assert: storedEvents isNotEmpty.
			self assert: storedEvents size equals: expectedStoredEvents size.
			expectedStoredEvents
				keysAndValuesDo: [ :index :eventMessageRegex |
					| serializer |
					serializer := self buildEventSerializer.
					self
						assertEvent: (serializer serialize: (storedEvents at: index))
						matchesEventRegex: (serializer serialize: eventMessageRegex) ] ]
		ifNil: [ allEvents := self application eventStore allEventsOfTenant: aTenant.
			self
				assert: allEvents
				equals: (OrderedCollection newFrom: previousEventsCollection) ]
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> checkSettingsLoaded [
	"Compatibility purposes"	
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> clearPreviousEvents [
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAEventSourcingEvent removeAll ]
		ifFalse: [ self fail: 'Not in integration test environment' ]
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> clearPreviousProjections [
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAProjection removeAllProjections ]
		ifFalse: [ self fail: 'Not in integration test environment' ]
	
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> clearQueues [
	self isEnvironmentIntegrationTest
		ifTrue: [ EDAQueueCleaner new deleteAllQueues ]
		ifFalse: [ self fail: 'Not in integration test environment' ]
]

{ #category : #helper }
EDATIntegrationTestBDD >> condenseString: aString [
	^ aString withBlanksCondensed select: [ :char | (char = Character cr or: [ char = Character lf ]) not ]
]

{ #category : #accessing }
EDATIntegrationTestBDD >> currentEnvironment [
	^ DUEnvironment currentEnvironment

]

{ #category : #accessing }
EDATIntegrationTestBDD >> currentEnvironment: env [
	DUEnvironment currentEnvironment: env
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> eventListener [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> eventListener: anObject [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #accessing }
EDATIntegrationTestBDD >> eventsSubscribed [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #accessing }
EDATIntegrationTestBDD >> eventsSubscribed: flag [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> findAllEventsOfTenant: aTenant forId: id andAggregateRootClass: aggregateRootClass inEventStore: eventStore [
	"Retrieves all events for given aggregate root"

	| result |
	self
		logDebugMessage:
			'Searching for all stored events of ' , aTenant , ' for aggregate root '
				aggregateRootClass greaseString , ' and id ' , id greaseString
				, '.'.
	result := eventStore
		findEventsOfTenant: aTenant ofAggregate: aggregateRootClass
		whereId: id.
	self
		logDebugMessage: 'Found: ' , result size greaseString , ' event(s).'.
	^ result
]

{ #category : #bdd }
EDATIntegrationTestBDD >> generatedEvent: frame matchesRegex: eventMessageRegex [
	| command body |
	command := frame command.
	body := frame body.
	self assert: command equals: #MESSAGE.
	self assertEvent: body matchesEventRegex: eventMessageRegex
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessage: aCommandMessage thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage [
	| expectedStoredEvents aCommandMessageCollection |
	expectedStoredEvents := expectedStoredEvent
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :event | OrderedCollection with: event ].
	aCommandMessageCollection := aCommandMessage
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :message | OrderedCollection with: message ].
	self
		givenPreviousEvents: previousEventsCollection
		ofTenant: aTenant
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessage: aCommandMessage thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage withRoutingKey: expectedRoutingKey [
	| expectedStoredEvents aCommandMessageCollection |
	expectedStoredEvents := expectedStoredEvent
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :event | OrderedCollection with: event ].
	aCommandMessageCollection := aCommandMessage
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :message | OrderedCollection with: message ].
	self
		givenPreviousEvents: previousEventsCollection
		ofTenant: aTenant
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])
		withRoutingKeys:
			(expectedRoutingKey
				ifNil: [ nil ]
				ifNotNil: [ :routingKey | OrderedCollection with: routingKey ])
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvent: expectedStoredEvent andPublishEventMessage: expectedEventMessage [
	| expectedStoredEvents |
	expectedStoredEvents := expectedStoredEvent
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :event | OrderedCollection with: event ].
	self
		givenPreviousEvents: previousEventsCollection
		ofTenant: aTenant
		whenReceiveCommandMessages: aCommandMessageCollection
		thenStoreEvents: expectedStoredEvents
		andPublishEventMessages:
			(expectedEventMessage
				ifNil: [ OrderedCollection new ]
				ifNotNil: [ :message | OrderedCollection with: message ])
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andLastPublishedEventMessage: expectedLastEventMessage [
	| frame lastFrame event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self
		storePreviousEvents: previousEventsCollection
		ofTenant: aTenant
		forApplicationId: appId
		andAggregateRootClass: rootClass.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection.
	[ [ frame := self eventListener client readMessage ]
		on: Error
		do: [ :err |
			self
				logErrorMessage: 'Error reading event from queue: ' , err greaseString.
			frame := nil ].
	frame notNil ] whileTrue: [ lastFrame := frame ].
	self generatedEvent: lastFrame matchesRegex: expectedLastEventMessage
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andLastPublishedEventMessage: expectedLastEventMessage withRoutingKey: expectedRoutingKey [
	| frame lastFrame appId rootClass event |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self
		storePreviousEvents: previousEventsCollection
		ofTenant: aTenant
		forApplicationId: appId
		andAggregateRootClass: rootClass.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection.
	[ [ frame := self client readMessage ]
		on: Error
		do: [ :err |
			self
				logErrorMessage: 'Error reading event from queue: ' , err greaseString.
			frame := nil ].
	frame notNil ] whileTrue: [ lastFrame := frame ].
	self generatedEvent: lastFrame matchesRegex: expectedLastEventMessage.
	self
		assert: (self routingKeyFromDestination: lastFrame destination)
		equals: expectedRoutingKey
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages [
	| event appId rootClass |
	event := previousEventsCollection first.
	appId := event id.
	rootClass := event aggregateRootClass.
	self
		storePreviousEvents: previousEventsCollection
		ofTenant: aTenant
		forApplicationId: appId
		andAggregateRootClass: rootClass.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection.
	expectedEventMessages
		do: [ :eventMessageRegex |
			| frame |
			frame := self eventListener client readMessage.
			self generatedEvent: frame matchesRegex: eventMessageRegex ]
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenPreviousEvents: previousEventsCollection ofTenant: aTenant whenReceiveCommandMessages: aCommandMessageCollection thenStoreEvents: expectedNewStoredEvents andPublishEventMessages: expectedEventMessages withRoutingKeys: expectedRoutingKeys [
	self storePreviousEvents: previousEventsCollection.
	aCommandMessageCollection
		do: [ :aCommandMessage | self publishCommand: aCommandMessage ].
	self subscribeToEvents.
	self
		assertEventMessagesMatch: expectedEventMessages
		withRoutingKeys: expectedRoutingKeys.
	self
		checkNewStoredEvents: expectedNewStoredEvents
		ofTenant: aTenant
		givenPreviousEvents: previousEventsCollection
]

{ #category : #testing }
EDATIntegrationTestBDD >> isEnvironmentIntegrationTest [
	^ self currentEnvironment = 'integration-tests'
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> isEvent: event inCollection: events [
	"Checks if the event is contained in given list"
	^ events anySatisfy: [ :e | e = event ]
	
]

{ #category : #testing }
EDATIntegrationTestBDD >> isEventStored: event [
	| events result message |
	"Checks if the event is indeed persisted"
	self
		logDebugMessage:
			'Searching for stored events for aggregate root '
				, event aggregateRootClass greaseString , ' and id '
				, event id greaseString , '.'.
	events := self application eventStore
		findEventsOfTenant: event tenant ofAggregate: event aggregateRootClass
		whereId: event id.
	self
		logDebugMessage: 'Found ' , events size greaseString , ' event(s).'.
	result := self isEvent: event inCollection: events.
	message := 'Event ' , event class greaseString.
	result
		ifFalse: [ message := message , 'NOT ' ].
	message := message , ' found in the event store'.
	self logDebugMessage: message.
	^ result
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> launchApplication [
	"Launches the test application"
	self application start
]

{ #category : #menu }
EDATIntegrationTestBDD >> loadSettings [
	self isEnvironmentIntegrationTest
		ifFalse: [ self currentEnvironment: 'integration-tests' "This triggers reloading of SettingBrowser" ]
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> prepareToLaunchApplication [
	"Compatibility purposes"	
	self shouldBeImplemented.
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> prepareToStopApplication [
	"Compatibility purposes"
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> publishCommand: commandString [
	^ EDAACommandStompTopicPublisher new publishMessage: commandString
]

{ #category : #helper }
EDATIntegrationTestBDD >> readFile: aFile [
	| result stream |
	stream := aFile readStream.
	result := stream contents.
	stream close.
	^ result
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> restoreOriginalEnvironment [
	(self currentEnvironment = self originalEnvironment)
		ifFalse:
			[ self originalEnvironment ifNotNil: [ :environmentValueToRestore | self currentEnvironment: environmentValueToRestore. OSPlatform current environment at: DUEnvironment environmentVariableName put: environmentValueToRestore ] ]
]

{ #category : #helper }
EDATIntegrationTestBDD >> routingKeyFromDestination: aDestinationString [
	^ (aDestinationString findTokens: '/') last.
]

{ #category : #initialization }
EDATIntegrationTestBDD >> setUp [
	super setUp.
	self
		logInfoMessage:
			'Running ' , thisContext receiver className greaseString , '>>'
				, thisContext receiver selector greaseString.
	self originalEnvironment: DUEnvironment currentEnvironment.
	self setUpCurrentEnvironment.
	self loadSettings.
	self prepareToLaunchApplication.
	self setUpApplication.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self clearQueues.
	self launchApplication.
	self timeLimit: EDAATestEventStompTopicListener timeout seconds
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> setUpApplication [
	"Prepares the test application"

	self application setup
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> setUpCurrentEnvironment [
	self isEnvironmentIntegrationTest
		ifFalse: [ OSPlatform current environment at: DUEnvironment environmentVariableName put: 'integration-tests' ]
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> showTranscript [
	Transcript class allSubInstances isEmpty ifTrue: [ Transcript open ]
	
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> stopApplication [
   self application stop
]

{ #category : #bdd }
EDATIntegrationTestBDD >> storePreviousEvents: eventsCollection [
	self logDebugMessage: 'Storing ' , eventsCollection size greaseString , ' event(s)...'.
	eventsCollection
		do: [ :event | 
			event save.
			self logDebugMessage: event className greaseString , ' stored.'.
			self logDebugMessage: event greaseString ].
	self application eventStore flush.
	self waitUntilEventsArePersisted: eventsCollection.
	self logDebugMessage: 'All ', eventsCollection size greaseString, ' event(s) stored'.

]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> storePreviousEvents: eventsCollection ofTenant: aTenant forApplicationId: appId andAggregateRootClass: rootClass [
	self
		logDebugMessage: 'Storing ' , eventsCollection size greaseString , ') event(s) ...'.
	eventsCollection
		do: [ :event |
			event save.
			self logDebugMessage: event className greaseString , ' inserted.' ].
	self application eventStore flush.
	self
		waitUntilEventsArePersisted: eventsCollection
		ofTenant: aTenant forApplicationId: appId
		andAggregateRootClass: rootClass.
	self
		logDebugMessage: 'All ' , eventsCollection size greaseString , ' events stored.'
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> subscribeToEvents [
	self eventListener: EDAATestEventStompTopicListener new.
	self subscriptionId: self eventListener subscribe.
	self eventsSubscribed: true.
	self logInfoMessage: 'Subscribed to events. subscriptionId is ' , self subscriptionId greaseString , '.'
]

{ #category : #accessing }
EDATIntegrationTestBDD >> subscriptionId [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #accessing }
EDATIntegrationTestBDD >> subscriptionId: anObject [
	"Compatibility purposes"
	self shouldBeImplemented
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> tearDown [
	super tearDown.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self clearQueues.
	self unsubscribeToEvents.
	self restoreOriginalEnvironment.
	self prepareToStopApplication.
	self stopApplication.
	self application reset.
	self
		logInfoMessage:
			'Finished ' , thisContext receiver className greaseString , '>>'
				, thisContext receiver selector greaseString
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> unsubscribe: id usingListener: aListener [
	| frame client |
	client := aListener client.
	[ (frame := StampUnsubscribeFrame new) id: id.
	client writeWithReceipt: frame ]
		ensure: [ client
				ifNotNil: [ [ client close ]
						on: ConnectionTimedOut
							do: [ self logErrorMessage: 'Timeout while unsubscribing ' , id greaseString , '.' ];
						on: StampError
							do: [ self logErrorMessage: 'Cannot unsubscribe ', id greaseString , '.'
									 ] ] ]
]

{ #category : #bdd }
EDATIntegrationTestBDD >> unsubscribeToEvents [
	self eventsSubscribed
		ifTrue: [
			self unsubscribe: self subscriptionId usingListener: self eventListener.
			self eventsSubscribed: false ]
		ifFalse: [
			self logDebugMessage: 'Already unsubscribed to events.']

]

{ #category : #helper }
EDATIntegrationTestBDD >> wait: maxWaitSeconds until: validateBlock evaluatesTo: expectedResult [
	"Copied from GLMMorphicTest #wait:validateBlock:evaluatesTo:"
	| startTime result |
	startTime := Time millisecondClockValue // 1000.
	[result := validateBlock value = expectedResult] whileFalse:
			[(Time millisecondClockValue // 1000) - startTime > maxWaitSeconds ifTrue: [^result].
			(Delay forMilliseconds: 50) wait].
	^ result
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> waitUntilEventsArePersisted: eventsCollection ofTenant: aTenant forApplicationId: appId andAggregateRootClass: aggregateRootClass [
	"Waits until all events are persisted"

	| events extraEvents |
	eventsCollection
		do: [ :event |
			(self
				wait: 10
				until: [ ^ self isEventStored: event ]
				evaluatesTo: true)
				ifFalse: [ self fail: 'Event ' , event class name , ' could not be persisted' ] ].
	events := self
		findAllEventsOfTenant: aTenant forId: appId
		andAggregateRootClass: aggregateRootClass
		inEventStore: self application eventStore.
	extraEvents := events
		collect: [ :e | eventsCollection anySatisfy: [ :ev | e = ev ] not ].
	extraEvents size > 0
		ifTrue: [ self
				fail:
					'Unexpected events found in the event store. Please clean up any prior event or command' ].
	self logDebugMessage: 'All events persisted. We can now go on.'
]
