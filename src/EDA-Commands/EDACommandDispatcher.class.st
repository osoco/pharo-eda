Class {
	#name : #EDACommandDispatcher,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper + EDACLogging',
	#classTraits : 'EDACPrintOnHelper classTrait + EDACLogging classTrait',
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

{ #category : #logging }
EDACommandDispatcher class >> logDebugMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandDispatcher class >> logErrorMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandDispatcher class >> logInfoMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandDispatcher class >> logTraceMessage: aMessage beautify: aBoolean [
	EDACLoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDACommandDispatcher class >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDACLoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

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
