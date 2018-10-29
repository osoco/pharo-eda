handling
invokeMethodHandlerWith: aCommand on: aReceiver
	self logDebugMessage: 'Handling command ', aCommand class name, '.'.
	^ aReceiver perform: self handlerMethod selector with: aCommand