handling
invokeMethodHandlerWith: aCommand on: aReceiver
	self logDebugMessage: 'Handling command ', aCommand class name greaseString , '.'.
	^ aReceiver perform: self handlerMethod selector with: aCommand