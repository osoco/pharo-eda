handling
invokeMethodHandlerWith: aCommand on: aReceiver
	self
		logDebugMessage: (String streamContents: [ :s | s nextPutAll: 'Handling command '; nextPutAll: aCommand class greaseString ]).
	^ aReceiver perform: self handlerMethod selector with: aCommand