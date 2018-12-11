mocking
setUpCommandHandlerMethod: resultingEventsCollection
	| aMethod handlerMethodSource aCommandHandlerReceiver |
	aCommandHandlerReceiver := self newClass.
	handlerMethodSource := String
		streamContents: [ :stream | 
			stream
				nextPutAll: 'handlerMethod: aCommand';
				cr;
				nextPutAll: '^ OrderedCollection newFrom: ';
				print: resultingEventsCollection asArray ].
	aCommandHandlerReceiver duringTestCompileSilently: handlerMethodSource.
	aMethod := aCommandHandlerReceiver >> #handlerMethod:.
	^ aMethod