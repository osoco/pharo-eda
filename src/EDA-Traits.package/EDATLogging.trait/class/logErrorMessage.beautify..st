logging
logErrorMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: FileStream stderr
				beautify: aBoolean ]