handling
invokeMethodHandlerWith: aCommand on: aReceiver
	Transcript
		print: 'Handling command ';
		print: aCommand class name;
		cr.
	^ aReceiver perform: self handlerMethod selector with: aCommand