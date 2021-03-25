Trait {
	#name : #EDATDomainBDD,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
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
								, ' is not able to handle events of type ' , eventClassName
								, ' and version ' , anEvent version greaseString ]
				ifFalse: [ anAggregateRoot perform: applyEventSelectorSymbol with: anEvent.
					anAggregateRoot version: (anAggregateRoot version + 1) ] ]
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

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol whenApplyingEvents: historicalEvents then: aBlock [
	| aggregateRoot |
	aggregateRoot := EDATestAggregateRoot with: (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	aggregateRoot isDeleted ifTrue: [ aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new ].
	aBlock value: aggregateRoot.
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvent: expectedResultingEvent [
	^ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvents: (OrderedCollection with: expectedResultingEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand ofType: aString thenEvents: expectedResultingEvents [
	| aux meta msg body aggregateRootVersion |
	aux := Dictionary new.
	meta := Dictionary new.
	meta at: #type put: aString.
	meta at: #id put: aCommand commandId greaseString.
	meta at: #version put: aCommand version.
	meta at: #timestamp put: DateAndTime now asString.
	aux at: #meta put: meta.
	body := Dictionary
		newFrom:
			(aCommand class allInstVarNames
				collect: [ :instVar | instVar -> (aCommand instVarNamed: instVar) ]).
	aCommand fillCommonInfoInto: body.
	aggregateRootVersion := historicalEvents ifEmpty: [ 0 ] ifNotEmpty: [ historicalEvents last aggregateRootVersion ].
	body at: #version put: aggregateRootVersion.
	aux at: #body put: body.
	msg := String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime
					customDo:
						[ :mapping | mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				nextPut: aux ].
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
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent [
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	aggregateRoot isDeleted
		ifTrue: [ aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new ].
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ | event |
			event := aggregateRoot
				perform: handlerSelectorSymbol
				with: aCommand.
			self assertEvent: expectedEvent equals: event ]
		ifFalse: [ self
				fail:
					'Aggregate root ' , anAggregateRootSymbol
						, ' does not know how to handle command ' , commandClassName ]
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents [
	| aux meta msg |
	aux := Dictionary new.
	meta := Dictionary new.
	meta at: #type put: aCommand name.
	aux at: #meta put: meta.
	aux at: #body put: (EDAJsonCommandSerializer new serialize: aCommand).
	msg := EDAJsonCommandSerializer new serialize: aux.
	^ self
		givenAggregate: anAggregateRootSymbol
		withEvents: historicalEvents
		whenReceiveMessage: msg
		thenEvents: expectedResultingEvents
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvent: expectedResultingEvent [
	^ self givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvents: (OrderedCollection with: expectedResultingEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveMessage: aString thenEvents: expectedResultingEvents [
	| commandConsumer resultingEvents mock eventStore |
	mock := EDAAcceptEverything new.
	eventStore := EDAVolatileEventStore new.
	eventStore
		saveEvents: historicalEvents.
	commandConsumer := EDACommandConsumer
		busListener: mock
		commandMaterializer: EDAJsonCommandMaterializer new
		commandDispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: eventStore
				eventProducer: mock
				andProjectorClass: mock).
	resultingEvents := commandConsumer
		consumeMessage: aString
		usingStrategy: EDAThrowError greaseString.
	self assert: resultingEvents isNotNil.
	self
		assert: resultingEvents size
		equals: expectedResultingEvents size.
	resultingEvents
		keysAndValuesDo: [ :i :actual | 
			| expected |
			(actual respondsTo: #dateCreated:)
				ifTrue: [ actual dateCreated: '<ANYTHING>' ].
			expected := expectedResultingEvents at: i.
			self assertEvent: actual equals: expected ]
]

{ #category : #helper }
EDATDomainBDD >> readFile: aFile [
	| fileStream result |
	fileStream := aFile readStream.
	result := fileStream contents.
	fileStream close.
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
