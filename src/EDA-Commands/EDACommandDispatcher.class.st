Class {
	#name : #EDACommandDispatcher,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'handlersRegistry'
	],
	#classInstVars : [
		'strategy'
	],
	#category : 'EDA-Commands-Handlers'
}

{ #category : #'instance creation' }
EDACommandDispatcher class >> withRegistry: aHandlersRegistry [
	^ self new
		handlersRegistry: aHandlersRegistry ;
		yourself
]

{ #category : #dispatching }
EDACommandDispatcher >> dispatch: aCommand [
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
	handler := aCommand isDelete
		ifTrue: [ EDADeleteCommandHandler uniqueInstance ]
		ifFalse: [ self handlersRegistry handlerForCommand: aCommand ].
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
	handler
		handle: aCommand
		withErrorStrategy: EDACommandConsumingErrorBehavior strategy
]

{ #category : #accessing }
EDACommandDispatcher >> handlersRegistry [
	^ handlersRegistry 
]

{ #category : #accessing }
EDACommandDispatcher >> handlersRegistry: aHandlersRegistry [
	handlersRegistry  := aHandlersRegistry
]
