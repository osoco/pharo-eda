Class {
	#name : #EDACommandDispatcher,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'handlersRegistry',
		'projectorClass'
	],
	#classInstVars : [
		'strategy'
	],
	#category : #'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDACommandDispatcher class >> withRegistry: aHandlersRegistry [
	^ self withRegistry: aHandlersRegistry  andProjectorClass: EDACompositeProjector
]

{ #category : #'instance creation' }
EDACommandDispatcher class >> withRegistry: aHandlersRegistry andProjectorClass: aClass [
	^ self new
		handlersRegistry: aHandlersRegistry;
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
		ifTrue: [ handler := EDADeleteCommandHandler uniqueInstance ].
	handler
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Command ';
								nextPutAll: aCommand class greaseString;
								nextPutAll: ' is not supported. Aggregate ';
								nextPutAll: aCommand aggregateRootClass greaseString;
								nextPutAll: ' is not prepared to handle it' ])
				andThrow: EDACommandHandlerNotFound ].
	^ handler
		handle: aCommand
		withErrorStrategy: aStrategy
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
