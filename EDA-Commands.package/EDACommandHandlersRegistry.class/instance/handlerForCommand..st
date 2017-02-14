registry
handlerForCommand: aCommand
	^ self handlers at: aCommand class ifAbsent: [  ]