mocking
setUpCommandHandlerSubclassMock: producedEventsCollection
	| aCommandHandlerClass  invokeCommandHandlerMethodSource |
	aCommandHandlerClass := self
		newSubclassOf: EDACommandHandler
		instanceVariableNames: 'invokedCommand invokedReceiver'
		classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'invokedCommand ^invokedCommand'.
	aCommandHandlerClass duringTestCompileSilently: 'invokedReceiver ^invokedReceiver'.	
	invokeCommandHandlerMethodSource := String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'invokeMethodHandlerWith: aCommand on: aReceiver'; cr;
				nextPutAll: 'invokedCommand := aCommand.'; cr;
				nextPutAll: 'invokedReceiver := aReceiver.'; cr;				
				nextPutAll: '^ OrderedCollection newFrom: ';
				print: producedEventsCollection asArray ].
	aCommandHandlerClass duringTestCompileSilently: invokeCommandHandlerMethodSource .
	^ aCommandHandlerClass