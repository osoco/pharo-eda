Trait {
	#name : #EDATDomainBDD,
	#traits : 'EDATLogging + EDATRegexHelper',
	#classTraits : 'EDATLogging classTrait + EDATRegexHelper classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #BDD }
EDATDomainBDD >> applyEvent: anEvent onAggregateRoot: anAggregateRoot [
	| eventClassName applyEventSelector applyEventSelectorSymbol error |
	eventClassName := anEvent class name.
	error := false.
	anEvent delete
		ifTrue: [ anAggregateRoot applyAggregateDeletedEvent: anEvent ]
		ifFalse: [ applyEventSelector := anAggregateRoot
				retrieveApplyEventMethod: anEvent
				withLogging: false.
			applyEventSelector
				ifNil: [ error := true ]
				ifNotNil: [ applyEventSelectorSymbol := applyEventSelector asSymbol.
					(anAggregateRoot respondsTo: applyEventSelectorSymbol)
						ifFalse: [ error := true ] ].
			error
				ifTrue: [ self
						fail:
							'Aggregate root ' , anAggregateRoot class name asSymbol
								, ' is not able to apply ' , eventClassName
								, ' events of version ' , anEvent version greaseString ]
				ifFalse: [ anAggregateRoot perform: applyEventSelectorSymbol with: anEvent.
					anAggregateRoot version: anAggregateRoot version + 1 ] ]
]

{ #category : #BDD }
EDATDomainBDD >> applyEvents: aCollectionOfEvents onAggregateRoot: anAggregateRoot [
	aCollectionOfEvents do: [ :anEvent | self applyEvent: anEvent onAggregateRoot: anAggregateRoot ]
]

{ #category : #BDD }
EDATDomainBDD >> applyEvents: aCollectionOfEvents onAggregateRootSymbol: anAggregateRootSymbol andAggregateMatchWith: aBlock [
| aggregateRoot |
aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	aCollectionOfEvents do: [ :anEvent | self applyEvent: anEvent onAggregateRoot: aggregateRoot ].
	aBlock value: aggregateRoot
]

{ #category : #BDD }
EDATDomainBDD >> assertEvent: actual equals: expected [
	| diff |
	diff := expected odDiff: actual.
	^ self
		assert: (diff isNil or: [ diff identical ])
		description: [ diff greaseString ]
]

{ #category : #helper }
EDATDomainBDD >> buildBodyForCommand: aCommand [
	^ self buildBodyForCommand: aCommand andAggregateRootVersion: 0
]

{ #category : #helper }
EDATDomainBDD >> buildBodyForCommand: aCommand andAggregateRootVersion: aVersion [
	| body |
	body := Dictionary
		newFrom:
			(aCommand class allInstVarNames
				collect: [ :instVar | instVar -> (aCommand instVarNamed: instVar) ]).
	aCommand fillCommonInfoInto: body.

	body at: #version put: aVersion.
	^ body

]

{ #category : #helper }
EDATDomainBDD >> buildMessageForCommand: aCommand ofType: aString [
	| aux |
	aux := Dictionary new.
	aux at: #meta put: (self buildMetaForCommand: aCommand ofType: aString).
	aux at: #body put: (self buildBodyForCommand: aCommand).
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime
					customDo:
						[ :mapping | mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				nextPut: aux ]
]

{ #category : #helper }
EDATDomainBDD >> buildMetaForCommand: aCommand ofType: aString [
	| meta |
	meta := Dictionary new.
	meta
		at: #type
		put: aString.
	meta at: #id put: aCommand commandId greaseString.
	meta at: #version put: aCommand version.
	meta at: #timestamp put: DateAndTime now asString.
	^ meta
]

{ #category : #helper }
EDATDomainBDD >> discardAgent: anEvent [
	(anEvent respondsTo: #agent:)
		ifTrue: [ anEvent agent: '<ANYTHING>' ]
]

{ #category : #helper }
EDATDomainBDD >> discardDateCreated: anEvent [
			(anEvent respondsTo: #dateCreated:)
				ifTrue: [ anEvent dateCreated: '<ANYTHING>' ].
]

{ #category : #helper }
EDATDomainBDD >> fixAggregateRootVersionsOfEvents: anEventCollection usingEventStore: anEventStore [
	^ EDACommandHandler addVersionToEvents: anEventCollection usingEventStore: anEventStore
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol whenApplyingEvents: historicalEvents then: aBlock [
	| aggregateRoot |
	aggregateRoot := EDATestAggregateRoot with: (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	aggregateRoot isDeleted ifTrue: [ aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new ].
	aBlock value: aggregateRoot.
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString shouldRaise: anException [
	^ self should: [ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvents: OrderedCollection empty ] raise: anException
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvent: expectedResultingEvent [
	^ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvents: (OrderedCollection with: expectedResultingEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvents: expectedResultingEvents [
	| msg |
	msg := self
		buildMessageForCommand: aCommand
		ofType: aString.
	^ self
		givenAggregate: anAggregateRootSymbol
		withEvents: historicalEvents
		whenReceiveMessage: msg
		thenEvents: expectedResultingEvents
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand shouldNotRaise: anException [
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ self shouldnt: [ aggregateRoot perform: handlerSelectorSymbol with: aCommand ] raise: anException ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand shouldRaise: anException [
	self
		should: [ 
			self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: OrderedCollection empty ]
		raise: anException
		
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent [
	^ self
		givenAggregate: anAggregateRootSymbol
		withEvents: historicalEvents
		whenReceiveCommand: aCommand
		thenEvents: (OrderedCollection with: expectedEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents [
	^ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: (EDAMessageSerializer nameForMessageClass: aCommand class) thenEvents: expectedResultingEvents 

]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvent: expectedResultingEvent [
	^ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvents: (OrderedCollection with: expectedResultingEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvents: expectedResultingEvents [
	| commandConsumer resultingEvents mock eventStore expectedEvents eventsToSave aggregateRootVersion msg eventsOfAggregate originalEventStores |
	mock := EDAAcceptEverything new.
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ self useEventStore: eventStore.
	eventsToSave := self
		fixAggregateRootVersionsOfEvents: historicalEvents
		usingEventStore: eventStore.
	eventStore saveEvents: eventsToSave.
	commandConsumer := EDACommandConsumer
		busListener: mock
		commandMaterializer: EDAJsonCommandMaterializer new
		commandDispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: eventStore
				eventProducer: mock
				andProjectorClass: mock).
	eventsOfAggregate := eventsToSave
		select:
			[ :e | e aggregateRootClass greaseString asSymbol = anAggregateRootSymbol ].
	aggregateRootVersion := eventsOfAggregate
		ifEmpty: [ 0 ]
		ifNotEmpty: [ eventsOfAggregate last aggregateRootVersion ].
	expectedEvents := self
		fixAggregateRootVersionsOfEvents: expectedResultingEvents
		usingEventStore: eventStore.
	msg := self
		provideAggregateRootVersion: aggregateRootVersion
		to: aString.
	resultingEvents := commandConsumer
		consumeMessage: aString
		usingStrategy: EDAThrowError greaseString.
	self assert: resultingEvents isNotNil.
	self assert: resultingEvents size equals: expectedEvents size.
	resultingEvents
		keysAndValuesDo: [ :i :actual | 
			| expected |
			expected := expectedEvents at: i.
			self discardDateCreated: expected.
			self discardAgent: expected.
			self assertEvent: expected equals: actual ] ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #'as yet unclassified' }
EDATDomainBDD >> old_givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand shouldRaise: anException [
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ self should: [ aggregateRoot perform: handlerSelectorSymbol with: aCommand ] raise: anException ]
		ifFalse: [ self fail: 'Aggregate root ' , anAggregateRootSymbol , ' does not know how to handle command ' , commandClassName ]
]

{ #category : #BDD }
EDATDomainBDD >> provideAggregateRootVersion: aggregateRootVersion to: aString [
	^ self replaceIn: aString allMatches: '\$\{AGGREGATE_ROOT_VERSION\}' with: aggregateRootVersion
]

{ #category : #helper }
EDATDomainBDD >> readFile: aFile [
	| fileStream result |
	fileStream := aFile readStream.
	result := fileStream contents.
	fileStream close.
	^ result
]

{ #category : #'test support' }
EDATDomainBDD >> restoreEventStores: aDictionary [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: (aDictionary at: c greaseString asSymbol) ]
]

{ #category : #'test support' }
EDATDomainBDD >> retrieveEventStores [
	| result |
	result := Dictionary new.
	EDAAggregateRepository
		allSubclassesDo: [ :c | result at: c greaseString asSymbol put: c eventStore ].
	^ result
]

{ #category : #helper }
EDATDomainBDD >> retrieveHandlerSelectorSymbol: aCommand [
	| result |
	aCommand isDelete
		ifTrue: [ result := #handleDeleteCommand: ]
		ifFalse: [ | pragmas methods |
			pragmas := Pragma
				allNamed: 'useAsCommandHandlerFor:'
				in: aCommand class aggregateRootClass.
			methods := (pragmas
				select: [ :p | (p argumentAt: 1) = aCommand className ])
				collect: [ :p | p method ].
			methods
				ifEmpty: [ self
						logErrorMessage:
							'No pragma-based methods found to handle '
								, aCommand className greaseString ].
			result := methods
				ifEmpty: [ ('handle' , aCommand classNameWithoutPrefix , ':') asSymbol ]
				ifNotEmpty: [ methods first selector ] ].
	^ result
]

{ #category : #'test support' }
EDATDomainBDD >> useEventStore: anEventStore [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: anEventStore ]
]
