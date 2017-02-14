accessing
invokeMethodHandlerWith: aCommand on: aReceiver
	^ aReceiver perform: self handlerMethod selector with: aCommand