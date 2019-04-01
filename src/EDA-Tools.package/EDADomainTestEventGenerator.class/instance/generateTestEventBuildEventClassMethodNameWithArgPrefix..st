code generation
generateTestEventBuildEventClassMethodNameWithArgPrefix: prefix
	^ 'fromEvent: ' , prefix , 'Event'