Class {
	#name : #EDACommandDispatcher,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'handlersRegistry',
		'projectorClass',
		'eventStore',
		'eventProducer'
	],
	#classInstVars : [
		'strategy'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDACommandDispatcher class >> withRegistry: aHandlersRegistry eventStore: anEventStore andEventProducer: anEventProducer [
	^ self
		withRegistry: aHandlersRegistry
		eventStore: anEventStore
		eventProducer: anEventProducer
		andProjectorClass: EDACompositeProjector
]

{ #category : #'instance creation' }
EDACommandDispatcher class >> withRegistry: aHandlersRegistry eventStore: anEventStore eventProducer: anEventProducer andProjectorClass: aClass [
	^ self new
		handlersRegistry: aHandlersRegistry;
		eventStore: anEventStore;
		eventProducer: anEventProducer;
		projectorClass: aClass;
		yourself
]

{ #category : #checking }
EDACommandDispatcher >> checkNonNullableAttributes: aCommand [
	aCommand invalidNonNullableAttributes
		do: [ :invalidNullAttribute |
			self
				logErrorMessage: 
					((aCommand errorLogForInvalidNonNullableAttribute: invalidNullAttribute)
						ifNil: [ self defaultLogForCommand: aCommand andInvalidNonNullableAttribute: invalidNullAttribute ])
				andThrow: aCommand class invalidCommandExceptionClass ]
]

{ #category : #checking }
EDACommandDispatcher >> defaultLogForCommand: aCommand andInvalidNonNullableAttribute: aInstVarSymbol [
	^ (String streamContents: [ :stream |
		stream
			nextPutAll: 'Invalid ';
			nextPutAll: aInstVarSymbol;
			nextPutAll: ' [nil] in command ';
			nextPutAll: aCommand className;
			nextPutAll: ' [';
			nextPutAll: aCommand greaseString;
			nextPutAll: ']' ])
]

{ #category : #dispatching }
EDACommandDispatcher >> dispatch: aCommand usingStrategy: aStrategy [
	| handler |
	aCommand
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Internal error: ';
								nextPutAll: self class greaseString;
								nextPutAll: '>>';
								nextPutAll: 'dispatch: received a nil command' ])
				andThrow: EDAInvalidCommandMessage ].
	aCommand version = aCommand class latestVersion
		ifFalse: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: self class greaseString;
								nextPutAll: ' rejected: version ';
								nextPutAll: aCommand version greaseString;
								nextPutAll: ' is not supported. Only version ';
								nextPutAll: aCommand class latestVersion greaseString;
								nextPutAll: ' is supported' ])
				andThrow: EDAInvalidCommandMessage ].
	self checkNonNullableAttributes: aCommand.
	handler := self handlersRegistry handlerForCommand: aCommand.
	(handler isNil and: [ aCommand isDelete ])
		ifTrue: [ handler := EDADeleteCommandHandler
				withEventStore: self eventStore
				eventBus: self eventProducer
				andProjectorClass: self projectorClass ].
	handler
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Command ';
								nextPutAll: aCommand class greaseString;
								nextPutAll: ' is not supported.'.
							aCommand aggregateRootClass
								ifNotNil: [ :c | 
									s
										nextPutAll: 'Aggregate ';
										nextPutAll: c greaseString;
										nextPutAll: ' is not prepared to handle it' ] ])
				andThrow: EDACommandHandlerNotFound ].
	^ handler handle: aCommand withErrorStrategy: aStrategy
]

{ #category : #accessing }
EDACommandDispatcher >> eventProducer [
	^ eventProducer
]

{ #category : #accessing }
EDACommandDispatcher >> eventProducer: anEventProducer [
	eventProducer := anEventProducer
]

{ #category : #accessing }
EDACommandDispatcher >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDACommandDispatcher >> eventStore: anEventStore [
	eventStore := anEventStore
]

{ #category : #accessing }
EDACommandDispatcher >> handlersRegistry [
	^ handlersRegistry 
]

{ #category : #accessing }
EDACommandDispatcher >> handlersRegistry: aHandlersRegistry [
	handlersRegistry  := aHandlersRegistry
]

{ #category : #accessing }
EDACommandDispatcher >> projectorClass [
	projectorClass ifNil: [ self projectorClass: EDACompositeProjector ].
	^ projectorClass
]

{ #category : #accessing }
EDACommandDispatcher >> projectorClass: anObject [
	projectorClass := anObject
]
