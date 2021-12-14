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
		do: [ self assert: expected asJsonString equals: actual asJsonString ]
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

{ #category : #'helper - command building' }
EDATDomainBDD >> buildCommandAttributesDictFromMessage: aCommandMessage [

	| commandJson commandMeta commandBody |
	commandJson := NeoJSONReader fromString: aCommandMessage.
	commandMeta := commandJson at: #meta.
	commandBody := commandJson at: #body.
	"It is the aggregateRootClass. Known by ATS<Command> class >> aggregateRootClass"
	commandMeta removeKey: #aggregate ifAbsent: [ ].
	commandMeta removeKey: #type ifAbsent: [ ].
	commandMeta removeKey: #correlationId ifAbsent: [ ].
	"It is the command message id."
	commandMeta changeKey: #id to: #commandId.
	commandMeta changeKey: #timestamp to: #originalTimestamp.
	"Transform to DateAndTime"
	commandMeta
		at: #originalTimestamp 
		ifPresent: [ :time |
			commandMeta at: #originalTimestamp put: (DateAndTime fromString: time) ].
	commandBody changeKey: #id to: #aggregateRootId.
	commandBody changeKey: #version to: #aggregateRootVersion.
	^ commandMeta | commandBody
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildEventAttributesDictFromFile: aFile [

	| eventMessage eventJson eventMeta eventBody |
	eventMessage := self readFile: aFile.
	eventJson := NeoJSONReader fromString: eventMessage.
	eventMeta := eventJson at: #meta.
	eventBody := eventJson at: #body.
	"It is the event message id. Not necessary to materialize event objet"
	eventMeta removeKey: #id ifAbsent: [ ].
	"It is the aggregateRootClass. Known by ATS<Event> class >> aggregateRootClass"
	eventMeta removeKey: #aggregate ifAbsent: [ ].
	"It is the class. Not necessary to materialize event objet. Already known"
	eventMeta removeKey: #type ifAbsent: [ ].
	eventMeta changeKey: #correlationId to: #commandId.
	eventBody changeKey: #version to: #aggregateRootVersion.
	eventBody
		at: #timestamp
		ifPresent: [ :bodyTimestamp |
			bodyTimestamp
				ifNil: [ 
					eventMeta at: #timestamp ifAbsentPut: [ nil ].
					eventBody removeKey: #timestamp ]
				ifNotNil: [
					eventMeta removeKey: #timestamp ifAbsent: [  ] ] ].

		
	^ eventMeta | eventBody
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
				prettyPrint: true;
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

{ #category : #'helper - command building' }
EDATDomainBDD >> buildSampleCommandFor: aCommandClass [
	| commandMessage |
	commandMessage := self readSampleFileFor: aCommandClass.
	self checkInstVarsFor: aCommandClass withAttributes: (self buildCommandAttributesDictFromMessage: commandMessage).
	^ ATSJsonCommandMaterializer new materialize: commandMessage.
]

{ #category : #'helper - command building' }
EDATDomainBDD >> buildSampleDeleteCommandFor: anAggregateClass [
	| commandMessage deleteCmd |
	commandMessage := self readSampleDeleteAggregateCommandFileFor: anAggregateClass.
	self checkInstVarsFor: EDADeleteAggregateCommand withAttributes: (self buildCommandAttributesDictFromMessage: commandMessage).
	deleteCmd :=  ATSJsonCommandMaterializer new materialize: commandMessage.
	deleteCmd aggregateRootClass: nil.
	^ deleteCmd
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildSampleEventFor: anEventClass [
	| attributes |
	attributes := self
		buildEventAttributesDictFromFile: (self readSampleFileFor: anEventClass).
	self checkInstVarsFor: anEventClass withAttributes: attributes.
	^ anEventClass
		ofTenant: (attributes at: #tenant)
		withAggregateId: (attributes at: #id)
		commandId: (attributes at: #commandId)
		andAttributes: attributes
	"	| eventMessage eventJson eventMeta eventBody evtAttributes evtCommandId evtTenant evtId evtTimestamp |
	eventMessage := self readFile: aFile.
	eventJson := NeoJSONReader fromString: eventMessage.
	eventMeta := eventJson at: #meta.
	eventBody := eventJson at: #body.
	evtAttributes := Dictionary new.
	evtAttributes at: 'version' put: (eventMeta at: 'version').
	evtAttributes at: 'aggregateRootVersion' put: (eventBody at: 'version').
	evtTenant := eventBody at: 'tenant'.
	evtId := eventBody at: 'id'.
	evtCommandId := eventMeta at: 'correlationId' ifAbsent: [ 'missing' ].
	evtTimestamp := eventBody at: 'timestamp' ifAbsent: [ nil ].
	evtTimestamp ifNil: [ evtTimestamp := eventMeta at: 'timestamp' ifAbsent: [ nil ] ].
	evtTimestamp ifNotNil: [ :t | evtAttributes at: 'timestamp' put: evtTimestamp ].
	eventBody at: #scopeContext ifPresent: [ :v | evtAttributes at: #scopeContext put: v ].
	eventBody at: #scopeKey ifPresent: [ :v | evtAttributes at: #scopeKey put: v ].
	eventBody at: 'canSaveDraft' ifPresent: [ :v | evtAttributes at: 'canSaveDraft' put: v ].
	eventBody at: 'confirmationMessage' ifPresent: [ :v | evtAttributes at: 'confirmationMessage' put: v ].
	eventBody at: 'contestId' ifPresent: [ :v | evtAttributes at: 'contestId' put: v ].
	eventBody at: 'contestKey' ifPresent: [ :v | evtAttributes at: 'contestKey' put: v ].
	eventBody at: 'contestName' ifPresent: [ :v | evtAttributes at: 'contestName' put: v ].
	eventBody at: 'defaultLanguage' ifPresent: [ :v | evtAttributes at: 'defaultLanguage' put: v ].
	eventBody at: 'formKey' ifPresent: [ :v | evtAttributes at: 'formKey' put: v ].
	eventBody at: 'gdpr' ifPresent: [ :v | evtAttributes at: 'gdpr' put: v ].
	eventBody at: 'languages' ifPresent: [ :v | evtAttributes at: 'languages' put: v ].
	eventBody at: 'legalConditions' ifPresent: [ :v | evtAttributes at: 'legalConditions' put: v ].
	eventBody at: 'public' ifPresent: [ :v | evtAttributes at: 'public' put: v ].
	eventBody at: 'recoveryZone' ifPresent: [ :v | evtAttributes at: 'recoveryZone' put: v ].
	eventBody at: 'sections' ifPresent: [ :v | evtAttributes at: 'sections' put: v ].
	eventBody at: 'sendingDataMessage' ifPresent: [ :v | evtAttributes at: 'sendingDataMessage' put: v ].
	eventBody at: 'showAllowShareDataCheck' ifPresent: [ :v | evtAttributes at: 'showAllowShareDataCheck' put: v ].
	eventBody at: 'summarySentence' ifPresent: [ :v | evtAttributes at: 'summarySentence' put: v ].
	eventBody at: 'timeoutErrorMessage' ifPresent: [ :v | evtAttributes at: 'timeoutErrorMessage' put: v ].
	eventBody at: 'widgetCustomizations' ifPresent: [ :v | evtAttributes at: 'widgetCustomizations' put: v ].
"
]

{ #category : #'helper - event building' }
EDATDomainBDD >> buildSampleEventFor: anEventClass withId: evtId andCommandId: inputCommandId [

	| aTestEvt |
	aTestEvt := self buildSampleEventFor: anEventClass.
	aTestEvt id: evtId.
	aTestEvt commandId: inputCommandId.
	^ aTestEvt
"
	| result |
	result := ATSTestFormCreated fromEvent: (self buildFormCreatedEventFromFile: self readFormCreatedFromFile).
	result id: evtId.
	result commandId: inputCommandId.
	^ result
"
]

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> checkInstVarsFor: aCommandOrEventClass withAttributes: attributes [
	| newInstVarsNeeded |
	newInstVarsNeeded := self
		newInstVarNeededFor: aCommandOrEventClass
		withAttributes: attributes.
	newInstVarsNeeded
		ifNotEmpty: [ :instvars | 
			self
				logErrorMessage: ((aCommandOrEventClass instVarsNeededMessageFor: self) value: instvars greaseString value: aCommandOrEventClass name)
				andThrow: (aCommandOrEventClass instVarsNeededExceptionFor: self) ]
	"	Automatic creation
	newInstVarsNeeded 
		do: [ :instVarName | 
			self addInstVarNamed: instVarName greaseString.
			formCreatedTestEvt
				instVarNamed: instVarName greaseString
				put: (theAttrs at: instVarName)
				ifAbsent: [ self logDebugMessage: 'No instVar created' ] ]."
]

{ #category : #'matching helpers - logs' }
EDATDomainBDD >> checkingLogForType: typeToCheckAsString element: aElement and: otherElement [
	^ 'Checking match ' , typeToCheckAsString , ' [' , aElement fullPrintString , '] with [' , otherElement fullPrintString , ']'
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
	(size := aCollection size) = otherObject size
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self
				mismatchCheckLogForType: checkingType
				element: aCollection
				and: otherObject
				andReason: 'different sizes'.
			self logDebugMessage: mismatchTypeLogMessage.
			collectionDiffDict add: aCollection -> otherObject.
			EDAMismatchError
				signal: mismatchTypeLogMessage
				withDiff: collectionDiffDict ].
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	1 to: size do: [ :index | 
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

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> commandInstVarsNeededException [
	^ EDACommandInstVarsNeeded
]

{ #category : #'helper - inst var checking' }
EDATDomainBDD >> commandInstVarsNeededMessage [
	^ [ :instvars :className | 'Check creation of instance variables: ' , instvars 
						, ' and accessors for class ' , className , ' or add them to its attributesReceivedNotRequired' ]
]

{ #category : #'helper - file readers' }
EDATDomainBDD >> commandSampleFilesPath [
	^ FileSystem disk workingDirectory / 'contracts' / 'Core' / 'commands'
]

{ #category : #'helper - file readers' }
EDATDomainBDD >> defaultSampleFileNameFor: aCommandOrEventClass [
	| classNamePrefixRemoved |
	
	"e.g. <classPrefix>CommandoreventNameUpperCamelCase -> commandorevent.name.upper.camel.case.example.json"
	"EDATLanguageHelper class >> removePrefix:from:
	EDASourceCodeHelperStub >> separateCamelCase:with:"
	classNamePrefixRemoved :=  ('^' , aCommandOrEventClass classPrefix copyReplaceAll: ':' with: '\:') asRegexIgnoringCase copy: aCommandOrEventClass name replacingMatchesWith: ''.
	^ ((classNamePrefixRemoved copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | '.' , each asLowercase  ]) allButFirst) , '.example.json'.
]

{ #category : #'matching helpers' }
EDATDomainBDD >> dictionary: aDictionary totallyMatchesWith: otherObject [
	| checkingType dictionaryDiffMessage dictionaryDiffDict aCollection |
	checkingType := aDictionary className.
	dictionaryDiffMessage := String empty.
	dictionaryDiffDict := Dictionary empty.
	self logDebugMessage: (self checkingLogForType: checkingType element: aDictionary and: otherObject).
	aCollection := (OrderedCollection with: aDictionary with: otherObject).
	(self anyUnnecessaryCheck: aCollection)
		ifTrue: [
			self unnecesaryCheckLogForType: checkingType element: aDictionary and: otherObject.
			^ self ].
	aDictionary == otherObject 
		ifTrue: [ 
			self logDebugMessage: 'Match by identity'.
			^ self ].
	((aDictionary species ~~ otherObject species) or: [ (otherObject isKindOf: Dictionary) not ])
		ifTrue: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self
				mismatchCheckLogForType: checkingType
				element: aDictionary
				and: otherObject
				andReason: 'different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			dictionaryDiffDict add: aDictionary -> otherObject.
			EDAMismatchError signal: mismatchTypeLogMessage withDiff: dictionaryDiffDict ].
	aDictionary size = otherObject size
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self mismatchCheckLogForType: checkingType element: aCollection and: otherObject andReason: 'different sizes'.
			self logDebugMessage: mismatchTypeLogMessage.
			dictionaryDiffDict add: aDictionary -> otherObject.
			EDAMismatchError
				signal: mismatchTypeLogMessage
				withDiff:dictionaryDiffDict ].
	"Done like this instead of with allSatisfy: to get all the different values in the future and show them on the visualization"
	aDictionary associationsDo: [ :assoc |
		| assocType aValue |
		assocType := String streamContents: [ :s | s nextPutAll: '#'; nextPutAll: assoc key greaseString; nextPutAll: ' dictionary association' ].
		aValue := assoc value.
		otherObject at: assoc key
			ifPresent: [ :otherValue |
				| mismatchValueMessage |
				[ aValue totallyMatches: otherValue forTest: self ]
					on: EDAMismatchError
					do: [ :ex |
						mismatchValueMessage := self mismatchCheckLogForType: assocType element: aValue and: otherValue andReason: ''.
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
				mismatchKeyMessage := self mismatchCheckLogForType: assocType element: assoc and: 'absent' andReason: 'missing key'.
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
			mismatchDictionaryMessage := self mismatchCheckLogForType: checkingType element: aDictionary and: otherObject andReason: 'associations mismatch'.
			self logDebugMessage: mismatchDictionaryMessage.
			dictionaryDiffMessage := String
				streamContents: [ :s | 
					s
						nextPutAll: mismatchDictionaryMessage;
						nextPutAll: (String with: Character cr with: Character lf with: Character tab);
						nextPutAll: dictionaryDiffMessage  ].
			EDAMismatchError signal: dictionaryDiffMessage withDiff: dictionaryDiffDict ].

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
	self checkingLogForType: 'event' element: anEvent and: otherEvent.
	eventCollection := OrderedCollection with: anEvent with: anEvent.
	(self anyUnnecessaryCheck: eventCollection)
		ifTrue: [
			self logDebugMessage: (self unnecesaryCheckLogForType: 'event' element: anEvent and: otherEvent).
			^ self ].
	(self areSameEventType: anEvent and: otherEvent)
		ifFalse: [ | mismatchTypeLogMessage |
			mismatchTypeLogMessage := self mismatchCheckLogForType: checkingType element: anEvent and: otherEvent andReason: 'by different types'.
			self logDebugMessage: mismatchTypeLogMessage.
			eventDiffMessage add: anEvent -> otherEvent.
			EDAMismatchError signal: mismatchTypeLogMessage withDiff: eventDiffMessage ].
	anEvent class allInstVarNames
		do: [ :varName | 
			| checkingInstVarMessage anEventVar otherEventVar |
			anEventVar := varName value: anEvent.
			otherEventVar := varName value: otherEvent.
			checkingInstVarMessage := self checkingLogForType: 'instance variable' element: anEventVar and: otherEventVar.
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

{ #category : #'helper - file readers' }
EDATDomainBDD >> eventSampleFilesPath [
	^ FileSystem disk workingDirectory / 'contracts' / 'Core' / 'events'
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
			| expected matchResult |
			expected := expectedEvents at: i.
			self discardDateCreated: expected.
			self discardAgent: expected.
			self assertEvent: expected deepMatches: actual.
			"matchResult := self event: expected totallyMatchesWith: actual.
			(matchResult at: #match)
			 ifFalse: [ 
				self assert: expected asJsonString = actual asJsonString description: [ matchResult at: #diff ] ]."
			"Keep for testing with old system"
			"self assert: expected asJsonString equals: actual asJsonString."
			"self assertEvent: expected equals: actual."
			"self assert: expected equals: actual."
			"self assertEvent: expected matches: actual" ] ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #'matching helpers - logs' }
EDATDomainBDD >> mismatchCheckLogForType: typeToCheckAsString element: anEvent and: otherEvent andReason: aReasonAsString [
	^ 'No match ' , typeToCheckAsString , ' [' , anEvent fullPrintString , '] with [' , otherEvent fullPrintString , '] by reason: ' , aReasonAsString
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

{ #category : #'helper - file readers' }
EDATDomainBDD >> readFile: aFile [
	| fileStream result |
	fileStream := aFile readStream.
	result := fileStream contents.
	fileStream close.
	^ result
]

{ #category : #'helper - file readers' }
EDATDomainBDD >> readSampleDeleteAggregateCommandFileFor: anAggregateClass [
	^ self readFile: ((EDADeleteAggregateCommand sampleFilesPathForTest: self) / ('v' , EDADeleteAggregateCommand latestVersion asString) / 'delete' , (self defaultSampleFileNameFor: anAggregateClass))

]

{ #category : #'helper - file readers' }
EDATDomainBDD >> readSampleFileFor: aCommandOrEventClass [
	^ self readFile: ((aCommandOrEventClass sampleFilesPathForTest: self) / ('v' , aCommandOrEventClass latestVersion asString) / (aCommandOrEventClass sampleFileNameForTest: self))

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
