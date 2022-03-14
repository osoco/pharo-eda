Trait {
	#name : #EDATDomainBDD,
	#traits : 'EDATLogging + EDATRegexHelper',
	#classTraits : 'EDATLogging classTrait + EDATRegexHelper classTrait',
	#category : #'EDA-Domain-Tests'
}

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> InstVarsNeededMessage [
	^ [ :instvars :className | 'Check creation of instance variables: ' , instvars 
						, ' and accessors for class ' , className , ' or add them to its attributesReceivedNotRequired' ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> anyUnnecessaryCheck: aCollection [
	^ aCollection anySatisfy: [ :elem | self unnecessaryCheck: elem ]
]

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

{ #category : #'matching helpers' }
EDATDomainBDD >> areSameEventType: anEvent and: otherEvent [
	^ (anEvent isKindOf: otherEvent class) or: [ otherEvent isKindOf:  anEvent class ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> assertEvent: actual deepMatches: expected [
	"This method raises an AssertionFailure if actual event is different (using #event:totallyMatchesWith: message) from expected.
	 Else it does nothing and execution continues.
	"
	[ self event: expected totallyMatchesWith: actual ]
		on: EDAMismatchError
		do: [ :ex | self assert: expected asJsonString equals: actual asJsonString ]
]

{ #category : #BDD }
EDATDomainBDD >> assertEvent: actual equals: expected [
	| diff |
	diff := expected odDiff: actual.
	^ self
		assert: (diff isNil or: [ diff identical ])
		description: [ diff greaseString ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> assertEvent: actual matches: expected [
	"This method raises an AssertionFailure if actual event is different (using #event:totallyMatchesWith: message) from expected.
	 Else it does nothing and execution continues.
	"
	^ self
		assert: (self event: actual totallyMatchesWith: expected)
		description: [ self comparingStringBetween: actual and: expected ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> assertEventJsonMsg: actual deepMatches: expected forEventClass: anEventClass [
	"This method raises an AssertionFailure if actual event json msg is different (using #eventJsonMsg:totallyMatchesWith: message) from expected.
	 Else it does nothing and execution continues.
	"
	[ self eventJsonMsg: expected totallyMatchesWith: actual forEventClass: anEventClass ]
		on: EDAMismatchError
		do: [ :ex | self assert: expected equals: actual ]
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildFlattenedEventJsonDictOfMessage: anEventJsonMsg [
	| eventJson eventMetaDict eventBodyDict |
	eventJson := NeoJSONReader fromString: anEventJsonMsg.
	eventMetaDict := eventJson at: #meta.
	self changeMetaToDomainAttributeNames: eventMetaDict.
	eventBodyDict := eventJson at: #body.
	self changeBodyToDomainAttributeNames: eventBodyDict.
	eventBodyDict
		at: #timestamp
		ifPresent: [ :bodyTimestamp |
			bodyTimestamp
				ifNil: [ 
					eventMetaDict at: #timestamp ifAbsentPut: [ nil ].
					eventBodyDict removeKey: #timestamp ]
				ifNotNil: [
					eventMetaDict removeKey: #timestamp ifAbsent: [  ] ] ].
	
	self checkDuplicatedFieldsInMeta: eventMetaDict andBody: eventBodyDict.
		
	^ eventMetaDict | eventBodyDict
]

{ #category : #'helper - command building' }
EDATDomainBDD >> buildSampleCommandFor: aCommandClass [
	| commandMessage commandJsonMessage |
	commandMessage := (EDATestCommandMessage forClass: aCommandClass).
	commandMessage checkInstVars.
	commandJsonMessage := commandMessage asJsonMessage.
	^ ATSJsonCommandMaterializer new materialize: commandJsonMessage.
]

{ #category : #'helper - command building' }
EDATDomainBDD >> buildSampleDeleteCommandFor: anAggregateClass [
	| deleteCommandMessage deleteCommandJsonMessage |
	deleteCommandMessage := (EDATestDeleteCommandMessage forClass: anAggregateClass).
	deleteCommandMessage checkInstVars.
	deleteCommandJsonMessage := deleteCommandMessage asJsonMessage.
	^ ATSJsonCommandMaterializer new materialize: deleteCommandJsonMessage
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildSampleEventFor: anEventClass [
	| eventMessage domainAttributes |
	eventMessage := (EDATestEventMessage forClass: anEventClass).
	eventMessage checkInstVars.
	domainAttributes := eventMessage domainAttributes.
	^ anEventClass
		ofTenant: (domainAttributes at: #tenant ifAbsent: [ nil ])
		withAggregateId: (domainAttributes at: #id)
		commandId: (domainAttributes at: #commandId)
		andAttributes: domainAttributes
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildSampleEventFor: anEventClass withId: evtId andCommandId: inputCommandId [

	| aTestEvt |
	aTestEvt := self buildSampleEventFor: anEventClass.
	aTestEvt id: evtId.
	aTestEvt commandId: inputCommandId.
	^ aTestEvt
]

{ #category : #'helper - event building' }
EDATDomainBDD >> changeBodyToDomainAttributeNames: eventBodyDict [
	eventBodyDict changeKey: #version to: #aggregateRootVersion
]

{ #category : #'helper - event building' }
EDATDomainBDD >> changeMetaToDomainAttributeNames: eventMetaDict [
	eventMetaDict changeKey: #id to: #messageId.
	eventMetaDict changeKey: #correlationId to: #commandId.

]

{ #category : #helper }
EDATDomainBDD >> checkDuplicatedFieldsInMeta: eventMetaDict andBody: eventBodyDict [
	| metaKeys bodyKeys |
	metaKeys := eventMetaDict keys.
	bodyKeys := eventBodyDict keys.
	(metaKeys intersection: bodyKeys) ifNotEmpty: [ :repeatedKeys | 
		self logErrorMessage: 'There are fields repeated in meta and body' andThrow: EDARepeatedFieldsInMetaAndBody ]
	
]

{ #category : #'matching helpers' }
EDATDomainBDD >> checkSizeOf: anElement and: otherElement [
	| mismatchTypeLogMessage |
	"Both elements must understand size message"
	anElement size = otherElement size
		ifTrue: [ ^ self ].
	mismatchTypeLogMessage := self
		mismatchCheckLogForType: anElement className
		element: anElement
		and: otherElement
		andReason: 'different sizes'.
	self logDebugMessage: mismatchTypeLogMessage.
	EDAMismatchError
		signal: mismatchTypeLogMessage
		withDiff: (Dictionary with: ('size:' , anElement size greaseString) -> ('size:' , otherElement size greaseString))
]

{ #category : #'matching helpers - logs' }
EDATDomainBDD >> checkingLogForType: typeToCheckAsString element: anElement and: otherElement [
	^ 'Checking match ' , typeToCheckAsString , ' [' , anElement fullPrintString , '] with [' , otherElement fullPrintString , ']'
]

{ #category : #'matching helpers' }
EDATDomainBDD >> collection: aCollection totallyMatchesWith: otherObject [
	| checkingType collectionDiffMessage collectionDiffDict elemsToCheck size |
	self flag: #TODO.
	"At the moment it seems that we only need it for SequenceableCollection. See in the future for Bag, Set, etc."
	checkingType := aCollection className.
	collectionDiffMessage := String empty.
	collectionDiffDict := Dictionary empty.
	self logDebugMessage: (self checkingLogForType: checkingType element: aCollection and: otherObject).
	elemsToCheck := OrderedCollection with: aCollection with: otherObject.
	(self anyUnnecessaryCheck: elemsToCheck)
		ifTrue: [ 
			self unnecesaryCheckLogForType: checkingType element: aCollection and: otherObject.
			^ self ].
	aCollection == otherObject
		ifTrue: [
			self logDebugMessage: 'Match by identity'.
			^ self ].
	"It gives problems with OrderedCollection <> Array
	aCollection species == otherObject species ifFalse: [ ^ false ]."
	(otherObject isKindOf: SequenceableCollection)
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self
				mismatchCheckLogForType: checkingType
				element: aCollection
				and: otherObject
				andReason: 'different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			collectionDiffDict add: aCollection -> otherObject.
			EDAMismatchError
				signal: mismatchTypeLogMessage
				withDiff: collectionDiffDict ].
	self checkSizeOf: aCollection and: otherObject.
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	1 to: aCollection size do: [ :index | 
		| aCollectionElement otherCollectionElement |
		aCollectionElement := aCollection at: index.
		otherCollectionElement := otherObject at: index.
		[ aCollectionElement
			totallyMatches: otherCollectionElement
			forTest: self ]
			on: EDAMismatchError
			do: [ :ex | 
				| elementType mismatchElementMessage |
				elementType := String
					streamContents: [ :s | 
						s
							nextPutAll: '#';
							nextPutAll: index greaseString;
							nextPutAll: ' collection elements' ].
				mismatchElementMessage := self
					mismatchCheckLogForType: elementType
					element: aCollectionElement
					and: otherCollectionElement
					andReason: ''.
				self logDebugMessage: mismatchElementMessage.
				collectionDiffDict at: #index put: ex diff.
				collectionDiffMessage := String
					streamContents: [ :s | 
						s
							nextPutAll: collectionDiffMessage;
							nextPutAll: (String with: Character cr with: Character lf);
							nextPutAll: mismatchElementMessage;
							nextPutAll: (String with: Character cr with: Character lf);
							nextPutAll: ex messageText;
							nextPutAll: (String with: Character cr with: Character lf) ] ] ].
	collectionDiffDict
		ifNotEmpty: [ | mismatchCollectionMessage |
			mismatchCollectionMessage := self mismatchCheckLogForType: checkingType element: aCollection and: otherObject andReason: 'elements mismatch'.
			self logDebugMessage: mismatchCollectionMessage.
			collectionDiffMessage := String
				streamContents: [ :s | 
					s
						nextPutAll: mismatchCollectionMessage;
						nextPutAll: (String with: Character cr with: Character lf with: Character tab);
						nextPutAll: collectionDiffMessage ].
			EDAMismatchError
				signal: collectionDiffMessage
				withDiff: collectionDiffDict ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> dictionary: aDictionary totallyMatchesWith: otherObject [
	| checkingType dictionaryDiffMessage dictionaryDiffDict aCollection |
	checkingType := aDictionary className.
	dictionaryDiffMessage := String empty.
	dictionaryDiffDict := Dictionary empty.
	self
		logDebugMessage:
			(self
				checkingLogForType: checkingType
				element: aDictionary
				and: otherObject).
	aCollection := OrderedCollection with: aDictionary with: otherObject.
	(self anyUnnecessaryCheck: aCollection)
		ifTrue: [ self
				unnecesaryCheckLogForType: checkingType
				element: aDictionary
				and: otherObject.
			^ self ].
	aDictionary == otherObject
		ifTrue: [ self logDebugMessage: 'Match by identity'.
			^ self ].
	(aDictionary species ~~ otherObject species
		or: [ (otherObject isKindOf: Dictionary) not ])
		ifTrue: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self
				mismatchCheckLogForType: checkingType
				element: aDictionary
				and: otherObject
				andReason: 'different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			dictionaryDiffDict add: aDictionary -> otherObject.
			EDAMismatchError
				signal: mismatchTypeLogMessage
				withDiff: dictionaryDiffDict ].
	self checkSizeOf: aDictionary and: otherObject.
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	aDictionary
		associationsDo: [ :assoc | 
			| assocType aValue |
			assocType := String
				streamContents: [ :s | 
					s
						nextPutAll: '#';
						nextPutAll: assoc key greaseString;
						nextPutAll: ' dictionary association' ].
			aValue := assoc value.
			otherObject
				at: assoc key
				ifPresent: [ :otherValue | 
					| mismatchValueMessage |
					[ aValue totallyMatches: otherValue forTest: self ]
						on: EDAMismatchError
						do: [ :ex | 
							mismatchValueMessage := self
								mismatchCheckLogForType: assocType
								element: aValue
								and: otherValue
								andReason: ''.
							self logDebugMessage: mismatchValueMessage.
							dictionaryDiffDict at: assoc key put: ex diff.
							dictionaryDiffMessage := String
								streamContents: [ :s | 
									s
										nextPutAll: dictionaryDiffMessage;
										nextPutAll: (String with: Character cr with: Character lf);
										nextPutAll: mismatchValueMessage;
										nextPutAll: (String with: Character cr with: Character lf);
										nextPutAll: ex messageText;
										nextPutAll: (String with: Character cr with: Character lf) ] ] ]
				ifAbsent: [ | mismatchKeyMessage |
					mismatchKeyMessage := self
						mismatchCheckLogForType: assocType
						element: assoc
						and: 'absent'
						andReason: 'missing key'.
					self logDebugMessage: mismatchKeyMessage.
					dictionaryDiffDict at: assoc key put: 'Absent'.
					dictionaryDiffMessage := String
						streamContents: [ :s | 
							s
								nextPutAll: dictionaryDiffMessage;
								nextPutAll: (String with: Character cr with: Character lf);
								nextPutAll: mismatchKeyMessage;
								nextPutAll: (String with: Character cr with: Character lf) ] ] ].
	dictionaryDiffDict
		ifNotEmpty: [ | mismatchDictionaryMessage |
			mismatchDictionaryMessage := self
				mismatchCheckLogForType: checkingType
				element: aDictionary
				and: otherObject
				andReason: 'associations mismatch'.
			self logDebugMessage: mismatchDictionaryMessage.
			dictionaryDiffMessage := String
				streamContents: [ :s | 
					s
						nextPutAll: mismatchDictionaryMessage;
						nextPutAll: (String with: Character cr with: Character lf with: Character tab);
						nextPutAll: dictionaryDiffMessage ].
			EDAMismatchError
				signal: dictionaryDiffMessage
				withDiff: dictionaryDiffDict ]
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

{ #category : #'matching helpers' }
EDATDomainBDD >> event: anEvent totallyMatchesWith: otherEvent [
	| checkingType eventDiffDict eventDiffMessage eventCollection |
	checkingType := anEvent className.
	eventDiffDict := Dictionary empty.
	eventDiffMessage := String empty.
	self logDebugMessage: (self checkingLogForType: 'event' element: anEvent and: otherEvent).
	eventCollection := OrderedCollection with: anEvent with: otherEvent.
	(self anyUnnecessaryCheck: eventCollection)
		ifTrue: [
			self logDebugMessage: (self unnecesaryCheckLogForType: 'event' element: anEvent and: otherEvent).
			^ self ].
	(self areSameEventType: anEvent and: otherEvent)
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self mismatchCheckLogForType: checkingType element: anEvent and: otherEvent andReason: 'by different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			eventDiffDict add: anEvent -> otherEvent.
			EDAMismatchError signal: mismatchTypeLogMessage withDiff: eventDiffDict ].
	anEvent class allInstVarNames
		do: [ :varName | 
			| checkingInstVarMessage anEventVar otherEventVar |
			anEventVar := varName value: anEvent.
			otherEventVar := varName value: otherEvent.
			checkingInstVarMessage := self checkingLogForType: varName greaseString element: anEventVar and: otherEventVar.
			self logDebugMessage: checkingInstVarMessage.
			[ anEventVar totallyMatches: otherEventVar forTest: self ]
				on: EDAMismatchError
				do: [ :ex | 
					(anEvent class isEventGenerated: varName greaseString)
						ifTrue: [ self
								logDebugMessage:
									(String
										streamContents: [ :stream | 
											stream
												nextPutAll: 'Match by ';
												nextPutAll: varName fullPrintString;
												nextPutAll: ' event generated' ]) ]
						ifFalse: [ | mismatchInstVarMessage |
							mismatchInstVarMessage := self mismatchCheckLogForType: varName element: anEventVar and: otherEventVar andReason: ''.
							self logDebugMessage: mismatchInstVarMessage.
							eventDiffDict at: varName put: ex diff.
							eventDiffMessage := String
								streamContents: [ :s | 
									s
										nextPutAll: eventDiffMessage;
										nextPutAll: String crlf; nextPutAll: String tab;
										nextPutAll: mismatchInstVarMessage;
										nextPutAll: String crlf; nextPutAll: String tab;
										nextPutAll: ex messageText;
										nextPutAll: String crlf ] ] ].
			self logDebugMessage: (String streamContents: [ :s | s nextPutAll: 'Match '; nextPutAll: varName greaseString ]) ].
	eventDiffDict ifNotEmpty: [ 
		eventDiffMessage := String 
			streamContents: [ :s | s
				nextPutAll: (self mismatchCheckLogForType: checkingType element: anEvent and: otherEvent  andReason: 'instance variables mismatch');
				nextPutAll: String crlf; nextPutAll: String tab;
				nextPutAll: eventDiffMessage ].
		EDAMismatchError signal: eventDiffMessage withDiff: eventDiffDict ]
]

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> eventInstVarsNeededException [
	^ EDAEventInstVarsNeeded
]

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> eventInstVarsNeededMessage [
	^ [ :instvars :className | 'Check creation of instance variables: ' , instvars 
						, ' and accessors for class ' , className ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> eventJsonMsg: anEventJsonMsg totallyMatchesWith: otherEventJsonMsg forEventClass: anEventClass [
	| checkingType eventDiffDict eventDiffMessage eventCollection anEventJsonFlattenedDict otherEventJsonFlattenedDict |
	checkingType := anEventJsonMsg className , ' Json Message'.
	eventDiffDict := Dictionary empty.
	eventDiffMessage := String empty.
	self logDebugMessage: (self checkingLogForType: 'eventJsonMsg:' element: anEventJsonMsg and: otherEventJsonMsg).
	eventCollection := OrderedCollection
		with: anEventJsonMsg
		with: otherEventJsonMsg.
	(self anyUnnecessaryCheck: eventCollection)
		ifTrue: [ self
				logDebugMessage:
					(self
						unnecesaryCheckLogForType: checkingType
						element: anEventJsonMsg
						and: otherEventJsonMsg).
			^ self ].
	(self areSameEventType: anEventJsonMsg and: otherEventJsonMsg)
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self
				mismatchCheckLogForType: checkingType
				element: anEventJsonMsg
				and: otherEventJsonMsg
				andReason: 'by different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			eventDiffDict add: anEventJsonMsg -> otherEventJsonMsg.
			EDAMismatchError
				signal: mismatchTypeLogMessage
				withDiff: eventDiffDict ].
	anEventJsonFlattenedDict := self buildFlattenedEventJsonDictOfMessage: anEventJsonMsg.
	otherEventJsonFlattenedDict := self buildFlattenedEventJsonDictOfMessage: otherEventJsonMsg.
	self
		checkSizeOf: anEventJsonFlattenedDict
		and: otherEventJsonFlattenedDict.
	anEventJsonFlattenedDict
		keysAndValuesDo: [ :anEventBodyKey :anEventBodyValue | 
			| checkingInstVarMessage otherEventBodyValue |
			otherEventBodyValue := otherEventJsonFlattenedDict
				at: anEventBodyKey.
			checkingInstVarMessage := self
				checkingLogForType: anEventBodyKey greaseString
				element: anEventBodyValue
				and: otherEventBodyValue.
			self logDebugMessage: checkingInstVarMessage.
			[ anEventBodyValue
				totallyMatches: otherEventBodyValue
				forTest: self ]
				on: EDAMismatchError
				do: [ :ex | 
					(anEventClass isEventGenerated: anEventBodyKey greaseString)
						ifTrue: [ self
								logDebugMessage:
									(String
										streamContents: [ :stream | 
											stream
												nextPutAll: 'Match by ';
												nextPutAll: anEventBodyKey fullPrintString;
												nextPutAll: ' event generated' ]) ]
						ifFalse: [ | mismatchInstVarMessage |
							mismatchInstVarMessage := self
								mismatchCheckLogForType: anEventBodyKey
								element: anEventBodyValue
								and: otherEventBodyValue
								andReason: ''.
							self logDebugMessage: mismatchInstVarMessage.
							eventDiffDict at: anEventBodyKey put: ex diff.
							eventDiffMessage := String
								streamContents: [ :s | 
									s
										nextPutAll: eventDiffMessage;
										nextPutAll: String crlf;
										nextPutAll: String tab;
										nextPutAll: mismatchInstVarMessage;
										nextPutAll: String crlf;
										nextPutAll: String tab;
										nextPutAll: ex messageText;
										nextPutAll: String crlf ] ] ].
			self
				logDebugMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Match ';
								nextPutAll: anEventBodyKey greaseString ]) ].
	eventDiffDict
		ifNotEmpty: [ eventDiffMessage := String
				streamContents: [ :s | 
					s
						nextPutAll:
							(self
								mismatchCheckLogForType: checkingType
								element: anEventJsonMsg
								and: otherEventJsonMsg
								andReason: 'instance variables mismatch');
						nextPutAll: String crlf;
						nextPutAll: String tab;
						nextPutAll: eventDiffMessage ].
			EDAMismatchError signal: eventDiffMessage withDiff: eventDiffDict ]
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
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveCommand: aCommand shouldRaise: anException [
	self
		should: [ 
			self givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: OrderedCollection empty ]
		raise: anException
		
]

{ #category : #BDD }
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent [
	^ self
		givenEvents: historicalEvents
		whenReceiveCommand: aCommand
		thenEvents: (OrderedCollection with: expectedEvent)
]

{ #category : #BDD }
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvent: expectedEvent andAdditionallyAssert: anExcepctedAndResultingEventsAssertionBlock [
	^ self
		givenEvents: historicalEvents
		whenReceiveCommand: aCommand
		thenEvents: (OrderedCollection with: expectedEvent)
		andAdditionallyAssert: anExcepctedAndResultingEventsAssertionBlock
]

{ #category : #BDD }
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents [
	^ self givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents andAdditionallyAssert: [ :expectedEvents :resultingEvents | true ]

]

{ #category : #BDD }
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveCommand: aCommand thenEvents: expectedResultingEvents andAdditionallyAssert: anExcepctedAndResultingEventsAssertionBlock [
	^ self
		givenEvents: historicalEvents
		whenReceiveMessage:
			aCommand asJsonMessage
		thenEvents: expectedResultingEvents
		andAdditionallyAssert: anExcepctedAndResultingEventsAssertionBlock
]

{ #category : #BDD }
EDATDomainBDD >> givenEvents: historicalEvents whenReceiveMessage: aString thenEvents: expectedResultingEvents [
	^ self givenEvents: historicalEvents whenReceiveMessage: aString thenEvents: expectedResultingEvents andAdditionallyAssert: [ :expectedEvents :resultingEvents | true ]
]

{ #category : #'matching helpers - logs' }
EDATDomainBDD >> mismatchCheckLogForType: typeToCheckAsString element: anElement and: otherElement andReason: aReasonAsString [
	^ 'No match ' , typeToCheckAsString , ' [' , anElement fullPrintString , '] with [' , otherElement fullPrintString , '] by reason: ' , aReasonAsString
]

{ #category : #'matching helpers' }
EDATDomainBDD >> mismatchInstVarMessage [
	^ [ :varName :anEventVar :otherEventVar | 
		String streamContents: [ :s |
			s nextPutAll: 'No match ';
			nextPutAll: varName greaseString;
			nextPut: Character cr;
			nextPut: Character lf;
			nextPutAll: anEventVar greaseString;
			nextPut: Character cr;
			nextPut: Character lf;
			nextPutAll: ' with ';
			nextPut: Character cr;
			nextPut: Character lf;
			nextPutAll: otherEventVar greaseString ] ]
]

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> newInstVarNeededFor: aCommandOrEventClass withAttributes: theAttrs [
	| receivedAttributes newInstVars |
	receivedAttributes := (theAttrs keys collect: [ :each | each asSymbol ]).
	newInstVars := (receivedAttributes \ aCommandOrEventClass attributesReceivedNotRequired) \ (aCommandOrEventClass allInstVarNames collect: [ :each | each asSymbol ]).
	^ newInstVars
]

{ #category : #'matching helpers' }
EDATDomainBDD >> object: anObject totallyMatchesWith: otherObject [
	| checkingType logs aCollection |
	checkingType := anObject className.
	logs := anObject isCharacter not.
	logs ifTrue: [ self logDebugMessage: (self checkingLogForType: checkingType element: anObject and: otherObject) ].
	aCollection := (OrderedCollection with: anObject with: otherObject).
	(self anyUnnecessaryCheck: aCollection)
		ifTrue: [ 
			self unnecesaryCheckLogForType: checkingType element: anObject and: otherObject.
			^ self ].
	anObject = otherObject
		ifTrue: [ logs ifTrue: (self logDebugMessage: 'Match by identity') ]
		ifFalse: [ | mismatchObjectMessage |
			mismatchObjectMessage := self mismatchCheckLogForType: checkingType element: anObject and: otherObject andReason: 'not identity'.
			EDAMismatchError signal: mismatchObjectMessage withDiff: (Dictionary with: anObject -> otherObject) ]

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

{ #category : #'test support' }
EDATDomainBDD >> restoreEventStores: aDictionary [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: (aDictionary at: c greaseString asSymbol) ]
]

{ #category : #'as yet unclassified' }
EDATDomainBDD >> restoreProjections [
	| projectionClasses |
	projectionClasses := EDAProjection allSubclasses
		reject: [ :projectionClass | 
			(projectionClass name beginsWithSubCollection: 'EDATest')
				or: [ projectionClass isAbstract ] ].
	projectionClasses add: EDAProjection.
	projectionClasses
		do:
			[ :projectionClass | 
			self tearDownProjectionRepositoryForTestProjection: projectionClass ]
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

{ #category : #'as yet unclassified' }
EDATDomainBDD >> setupProjectionRepositoryForTestProjection: aProjectionClass [
	aProjectionClass repository: EDAProjectionMemoryRepository new
]

{ #category : #'as yet unclassified' }
EDATDomainBDD >> setupTestProjections [
	| projectionClasses |
	projectionClasses := EDAProjection allSubclasses
		reject: [ :projectionClass | 
			(projectionClass name beginsWithSubCollection: 'EDATest')
				or: [ projectionClass isAbstract ] ].
	projectionClasses add: EDAProjection.
	projectionClasses
		do:
			[ :projectionClass | 
			self setupProjectionRepositoryForTestProjection: projectionClass ]
]

{ #category : #'as yet unclassified' }
EDATDomainBDD >> tearDownProjectionRepositoryForTestProjection: aProjectionClass [
	aProjectionClass repository: nil
]

{ #category : #'matching helpers - logs' }
EDATDomainBDD >> unnecesaryCheckLogForType: typeToCheckAsString element: anEvent and: otherEvent [
	^ 'Unnecesary Check for ' , typeToCheckAsString , ' [' , anEvent fullPrintString , '] and [' , otherEvent fullPrintString , ']'
]

{ #category : #'matching helpers' }
EDATDomainBDD >> unnecessaryCheck: anObject [
	| isUnnecessary |
	isUnnecessary := self wildCards includes: anObject.
	isUnnecessary ifTrue: [ self logDebugMessage: 'Match by unnecessary check' ].
	^ isUnnecessary
]

{ #category : #'test support' }
EDATDomainBDD >> useEventStore: anEventStore [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: anEventStore ]
]

{ #category : #'matching helpers' }
EDATDomainBDD >> wildCards [
	^ Set
		with: '<ANYTHING>'
		with: '1970-01-01T00:00:00'.
]

{ #category : #'matching helpers' }
EDATDomainBDD >> working_collection: aCollection totallyMatchesWith: otherObject [
	| differences elemsToCheck size |
	self flag: #TODO.
	"At the moment it seems that we only need it for SequenceableCollection. See in the future for Bag, Set, etc."
	differences := Dictionary with: #match -> true with: #diff -> nil.
	self logDebugMessage: 'Checking match collection ' , aCollection fullPrintString , ' with ' , otherObject fullPrintString.
	elemsToCheck := (OrderedCollection with: aCollection with: otherObject).
	(self anyUnnecessaryCheck: elemsToCheck) ifTrue: [ ^ true ].
	aCollection == otherObject
		ifTrue: [ 
			self logDebugMessage: 'Match by identity'.
			^ true ].
	"It gives problems with OrderedCollection <> Array
	aCollection species == otherObject species ifFalse: [ ^ false ]."
	(otherObject isKindOf: SequenceableCollection)
		ifFalse: [ 
			self logDebugMessage: 'No match collection ' , aCollection fullPrintString , ' with ' , otherObject fullPrintString , ' by not SequenceableCollection'.
			^ false ].
	(size := aCollection size) = otherObject size
		ifFalse: [ 
			self logDebugMessage: 'No match collection ' , aCollection fullPrintString , ' with ' , otherObject fullPrintString , ' by different sizes'.
			^ false ].
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	1 to: size do: [ :index |
		((aCollection at: index) totallyMatches: (otherObject at: index) forTest: self)
			ifFalse: [ 
				self logDebugMessage: 'No match collection ' , aCollection fullPrintString , ' with ' , otherObject fullPrintString , ' by elements'.
				^ false ] ].
	^ true
]

{ #category : #'matching helpers' }
EDATDomainBDD >> working_dictionary: aDictionary totallyMatchesWith: otherObject [
	| aCollection |
	self logDebugMessage: 'Checking match dictionary ' , aDictionary fullPrintString , ' with ' , otherObject fullPrintString.
	aCollection := (OrderedCollection with: aDictionary with: otherObject).
	(self anyUnnecessaryCheck: aCollection) ifTrue: [ ^ true ].
	aDictionary == otherObject 
		ifTrue: [ 
			self logDebugMessage: 'Match by identity'.
			^ true ].
	aDictionary species == otherObject species
		ifFalse: [
			self logDebugMessage: 'No match dictionary ' , aDictionary fullPrintString , ' with ' , otherObject fullPrintString , ' by different species'.
			^ false ].
	(otherObject isKindOf: Dictionary) ifFalse: [ ^ false ].
	aDictionary size = otherObject size
		ifFalse: [ 
			self logDebugMessage: 'No match dictionary ' , aDictionary fullPrintString , ' with ' , otherObject fullPrintString , ' by different sizes'.
			^ false ].
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	aDictionary associationsDo: [ :assoc |
		(assoc value totallyMatches: (otherObject at: assoc key ifAbsent: [ ^ false ]) forTest: self)
			ifFalse: [
				self logDebugMessage: 'No match dictionary ' , aDictionary fullPrintString , ' with ' , otherObject fullPrintString , ' by elements'. 
				^ false ] ].
	^ true
]

{ #category : #'matching helpers' }
EDATDomainBDD >> working_event: anEvent totallyMatchesWith: otherEvent [
	| eventCollection differences |
	differences := Dictionary with: #match -> true with: #diff -> nil.
	self checkingLogForType: 'event' element: anEvent and: otherEvent.
	eventCollection := OrderedCollection with: anEvent with: anEvent.
	(self anyUnnecessaryCheck: eventCollection)
		ifTrue: [ ^ differences ].
	(self areSameEventType: anEvent and: otherEvent)
		ifFalse: [
			| message |
			message := 'No match event ' , anEvent fullPrintString , ' with ' , otherEvent fullPrintString , ' by different event type'.
			self
				logDebugMessage: message.
			differences at: #match put: false.
			differences at: #diff put: message.
			^ differences ].
	anEvent class allInstVarNames
		allSatisfy: [ :varName | 
			| varMatch anEventVar otherEventVar |
			self
				logDebugMessage: (String streamContents: [ :s | s nextPutAll: 'Checking instance variable '; nextPutAll: varName greaseString ]).
			anEventVar := (varName value: anEvent).
			otherEventVar := (varName value: otherEvent).
			varMatch := 
				(anEventVar totallyMatches: otherEventVar forTest: self)
				or: [ | attributeGenerated |
					attributeGenerated := anEvent class
						isEventGenerated: varName greaseString.
					attributeGenerated
						ifTrue: [ 
							self logDebugMessage: 
								(String streamContents: [ :stream | stream nextPutAll: 'Match by '; nextPutAll: varName fullPrintString; nextPutAll: ' event generated' ]) ].
					attributeGenerated ].
			varMatch
				ifTrue: [ self logDebugMessage: (String streamContents: [ :s | s nextPutAll: 'Match ' ; nextPutAll: varName greaseString ]) ]
				ifFalse: [ 
					| message |
					message := String streamContents: [ :s | s nextPutAll: 'No match '; nextPutAll: varName greaseString; nextPut: Character cr; nextPut: Character lf; nextPutAll: anEventVar greaseString; nextPut: Character cr; nextPut: Character lf; nextPutAll: ' with '; nextPut: Character cr; nextPut: Character lf; nextPutAll: otherEventVar greaseString ].
					self logDebugMessage: message.
					differences at: #match put: false.
					differences at: #diff put: message.
					^ differences ].
			varMatch ].
		^ differences 
]

{ #category : #'matching helpers' }
EDATDomainBDD >> working_object: anObject totallyMatchesWith: otherObject [
	| logs aCollection objectsEquality |
	logs := anObject isCharacter not.
	logs ifTrue: [ self logDebugMessage: 'Checking match object ' , anObject fullPrintString , ' with ' , otherObject fullPrintString ].
	aCollection := (OrderedCollection with: anObject with: otherObject).
	(self anyUnnecessaryCheck: aCollection) ifTrue: [ ^ true ].
	objectsEquality := anObject = otherObject.
	logs ifTrue: [ self logDebugMessage: (objectsEquality ifTrue: [ 'Match ' ] ifFalse: [ 'Dismatch ' ]) , ' by identity' ].
	^ objectsEquality

]
