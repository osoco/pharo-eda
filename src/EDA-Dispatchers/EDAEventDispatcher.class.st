Class {
	#name : #EDAEventDispatcher,
	#superclass : #EDADispatcher,
	#category : #'EDA-Dispatchers-Event'
}

{ #category : #dispatching }
EDAEventDispatcher >> dispatch: anEvent usingStrategy: aStrategy [
	| handler |
	anEvent
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Internal error: ';
								nextPutAll: self class greaseString;
								nextPutAll: '>>';
								nextPutAll: 'dispatch: received a nil command' ])
				andThrow: EDAInternalError ].
	handler := self handlersRegistry handlerForEvent: anEvent.
	handler
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'Event ';
								nextPutAll: anEvent class greaseString;
								nextPutAll: ' is not supported.' ])
				andThrow: EDAEventHandlerNotFound ].
	^ handler handle: anEvent withErrorStrategy: aStrategy
]
