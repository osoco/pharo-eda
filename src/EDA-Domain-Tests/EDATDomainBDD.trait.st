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
	anEvent delete ifTrue: [ anAggregateRoot applyAggregateDeletedEvent: anEvent ] ifFalse: [ 
	applyEventSelector := anAggregateRoot retrieveApplyEventMethod: anEvent withLogging: false.
	applyEventSelector
		ifNil: [ error := true ]
		ifNotNil: [ applyEventSelectorSymbol := applyEventSelector asSymbol.
			(anAggregateRoot respondsTo: applyEventSelectorSymbol)
				ifFalse: [ error := true ] ].
	error
		ifTrue: [ self fail: 'Aggregate root ' , anAggregateRoot class name asSymbol , ' is not able to handle events of type ' , eventClassName , ' and version ' , anEvent version greaseString]
		ifFalse: [ anAggregateRoot perform: applyEventSelectorSymbol with: anEvent  ] ]
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
			event aggregateRootVersion: aCommand aggregateRootVersion + 1.
			self assertEvent: expectedEvent equals: event ]
		ifFalse: [ self
				fail:
					'Aggregate root ' , anAggregateRootSymbol
						, ' does not know how to handle command ' , commandClassName ]
]

{ #category : #BDD }
EDATDomainBDD >> givenAggregate: anAggregateRootSymbol withEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents [
	| aggregateRoot handlerSelectorSymbol commandClassName |
	aggregateRoot := (Smalltalk at: anAggregateRootSymbol) new.
	self applyEvents: historicalEvents onAggregateRoot: aggregateRoot.
	commandClassName := aCommand class name.
	handlerSelectorSymbol := self retrieveHandlerSelectorSymbol: aCommand.
	(aggregateRoot respondsTo: handlerSelectorSymbol)
		ifTrue: [ | resultingEvents |
			resultingEvents := aggregateRoot
				perform: handlerSelectorSymbol
				with: aCommand.
			self assert: resultingEvents isNotNil.
			self
				assert: resultingEvents size
				equals: expectedResultingEvents size.
			resultingEvents
				keysAndValuesDo: [ :i :e | 
					self assert: (expectedResultingEvents at: i) equals: e.
					e aggregateRootClass = aCommand class aggregateRootClass
						ifTrue: [ e aggregateRootVersion: aCommand aggregateRootVersion + 1 ] ] ]
		ifFalse: [ self
				fail:
					'Aggregate root ' , anAggregateRootSymbol
						, ' does not know how to handle command ' , commandClassName ]
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
