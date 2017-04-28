code generation - test support
generateTestEventBuildEventClassMethodNameWithArgPrefix: prefix
	^ 'fromEvent: ' , prefix , 'Event'