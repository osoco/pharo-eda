Class {
	#name : #EDACommandDispatcher,
	#superclass : #EDADispatcher,
	#instVars : [
		'projectorClass'
	],
	#classInstVars : [
		'strategy'
	],
	#category : #'EDA-Dispatchers-Command'
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
	| result |
	result := super
		withRegistry: aHandlersRegistry
		eventStore: anEventStore
		andEventProducer: anEventProducer.
	result
		projectorClass: aClass.
^ result
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
				andThrow: EDAInvalidCommand ].
	aCommand version = aCommand latestVersion
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
				andThrow: EDAInvalidCommand ].
	handler := self retrieveHandlerFor: aCommand.
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
EDACommandDispatcher >> projectorClass [
	projectorClass ifNil: [ self projectorClass: EDACompositeProjector ].
	^ projectorClass
]

{ #category : #accessing }
EDACommandDispatcher >> projectorClass: anObject [
	projectorClass := anObject
]

{ #category : #helpers }
EDACommandDispatcher >> retrieveHandlerFor: aCommand [
	^ self handlersRegistry handlerForCommand: aCommand
]
