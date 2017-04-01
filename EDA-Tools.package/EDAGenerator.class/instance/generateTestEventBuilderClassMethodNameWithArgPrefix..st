code generation - test support
generateTestEventBuilderClassMethodNameWithArgPrefix: prefix
	^ 'fromEvent: ' , prefix , 'Event'