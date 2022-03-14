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
	#traits : 'EDATJsonMatchingHelper + EDATLogging',
	#classTraits : 'EDATJsonMatchingHelper classTrait + EDATLogging classTrait',
	#category : #'EDA-Commands-Tests'
}

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

{ #category : #asserting }
EDATIntegrationTestBDD >> assertNextReceivedEventFromListener: stompListener matches: anEvent [
	| frame ack nack |
	self logInfoMessage: 'Waiting for incoming messages...'.
	[ frame := stompListener client readMessage.
	ack := frame ackFrame.
	nack := frame nackFrame.
	stompListener client write: ack.
	self logDebugMessage: 'Received event: ' , frame body greaseString.
	self assertReadedFrame: frame matchesEvent: anEvent.
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

{ #category : #bdd }
EDATIntegrationTestBDD >> assertPublishedEvents: expectedEvents withRoutingKeys: expectedRoutingKeys [
	| anyEventGenerated |
	[
		anyEventGenerated := false.
		expectedEvents	doWithIndex: [ :event :index |
			| frame |
			frame := self assertNextReceivedEventFromListener: self eventListener matches: event.
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
EDATIntegrationTestBDD >> assertReadedFrame: frame matchesEvent: anEvent [
	| command body |
	command := frame command.
	body := frame body.
	self assert: command equals: #MESSAGE.
	self assertEventJsonMsg: body deepMatches: anEvent asJsonMessage forEventClass: anEvent class
]

{ #category : #helper }
EDATIntegrationTestBDD >> buildEventSerializer [
	^ EDAJsonEventSerializer new
]

{ #category : #bdd }
EDATIntegrationTestBDD >> checkNewStoredEvents: expectedNewStoredEvents givenPreviousEvents: previousEventsCollection [
	| newExpectedEvents storedEvents expectedStoredEvents |
	storedEvents := (self application eventStore allEvents).
	newExpectedEvents := expectedNewStoredEvents ifNil: [ OrderedCollection empty ].
	expectedStoredEvents := OrderedCollection newFrom: previousEventsCollection.
	expectedStoredEvents addAll: newExpectedEvents.
	self assert: storedEvents size equals: expectedStoredEvents size.
	expectedStoredEvents
		withIndexDo: [ :expectedEvent :index |
			self assertEvent: expectedEvent deepMatches: (storedEvents at: index) ]
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
	^ EDADUEnvironment currentEnvironment

]

{ #category : #accessing }
EDATIntegrationTestBDD >> currentEnvironment: env [
	EDADUEnvironment currentEnvironment: env
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
EDATIntegrationTestBDD >> givenEvents: previousEvents whenReceiveCommand: aCommand thenStoreAndPublishEvent: expectedEvent withRoutingKey: expectedRoutingKey [
	| expectedEvents receivedCommands excepctedRoutingKeys |
	expectedEvents := self transformToCollection: expectedEvent.
	receivedCommands := self transformToCollection: aCommand.
	excepctedRoutingKeys := self transformToCollection: expectedRoutingKey.
	self
		givenEvents: previousEvents
		whenReceiveCommands: receivedCommands
		thenStoreAndPublishEvents: expectedEvents
		withRoutingKeys: excepctedRoutingKeys
]

{ #category : #bdd }
EDATIntegrationTestBDD >> givenEvents: previousEvents whenReceiveCommands: receivedCommands thenStoreAndPublishEvents: expectedEvents withRoutingKeys: expectedRoutingKeys [
	| versionFixedPreviousEvents versionFixedExpectedEvents |
	versionFixedPreviousEvents := self fixAggregateRootVersionsOfEvents: previousEvents usingEventStore: self application eventStore.
	self storePreviousEvents: versionFixedPreviousEvents.
	versionFixedExpectedEvents :=  self fixAggregateRootVersionsOfEvents: expectedEvents usingEventStore: self application eventStore.
	receivedCommands
		do: [ :aCommand | self publishCommand: aCommand asJsonMessage ].
	self subscribeToEvents.
	self
		assertPublishedEvents: versionFixedExpectedEvents
		withRoutingKeys: expectedRoutingKeys.
	self
		checkNewStoredEvents: versionFixedExpectedEvents
		givenPreviousEvents: versionFixedPreviousEvents
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
	^ EDACommandStompTopicPublisher new publishMessage: commandString
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> restoreOriginalEnvironment [
	(self currentEnvironment = self originalEnvironment)
		ifFalse:
			[ self originalEnvironment ifNotNil: [ :environmentValueToRestore | self currentEnvironment: environmentValueToRestore. OSPlatform current environment at: EDADUEnvironment environmentVariableName put: environmentValueToRestore ] ]
]

{ #category : #helper }
EDATIntegrationTestBDD >> routingKeyFromDestination: aDestinationString [
	^ (aDestinationString findTokens: '/') last.
]

{ #category : #helper }
EDATIntegrationTestBDD >> setTimeStampToEvent: anEvent [
	anEvent timestamp: DateAndTime now asUTC
]

{ #category : #initialization }
EDATIntegrationTestBDD >> setUp [
	super setUp.
	self
		logInfoMessage:
			'Running ' , thisContext receiver className greaseString , '>>'
				, thisContext receiver selector greaseString.
	self originalEnvironment: EDADUEnvironment currentEnvironment.
	self setUpCurrentEnvironment.
	self loadSettings.
	self prepareToLaunchApplication.
	self setUpApplication.
	self clearPreviousEvents.
	self clearPreviousProjections.
	self clearQueues.
	self launchApplication.
	self timeLimit: EDATestEventStompTopicListener timeout seconds
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> setUpApplication [
	"Prepares the test application"

	self application setup
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> setUpCurrentEnvironment [
	self isEnvironmentIntegrationTest
		ifFalse: [ OSPlatform current environment at: EDADUEnvironment environmentVariableName put: 'integration-tests' ]
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
			self setTimeStampToEvent: event.
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
	self eventListener: EDATestEventStompTopicListener new.
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

{ #category : #'as yet unclassified' }
EDATIntegrationTestBDD >> transformToCollection: anObject [
	^ anObject
		ifNil: [ OrderedCollection empty ]
		ifNotNil: [ :object | OrderedCollection with: object ].
]

{ #category : #lifecycle }
EDATIntegrationTestBDD >> unsubscribe: id usingListener: aListener [
	| frame client |
	client := aListener client.
	[ (frame := StampUnsubscribeFrame new) id: id.
	[ client writeWithReceipt: frame ]
		on: Error do: [ :ex | self logErrorMessage: 'Unsubscribe error ' ,  ex messageText greaseString ]  ]
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
			self eventListener unsubscribe.
			self eventsSubscribed: false ]
		ifFalse: [
			self logDebugMessage: 'Already unsubscribed to events.' ]

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
