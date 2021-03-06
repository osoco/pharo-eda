dispatching
dispatch: aCommand
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