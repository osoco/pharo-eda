dispatching
dispatch: aCommand
	| handler |
	aCommand
		ifNil: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Internal error: '; nextPutAll: self class greaseString;
								nextPutAll: '>>';
								nextPutAll: 'dispatch: received a nil command' ])
				andThrow: EDACommandError ].
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