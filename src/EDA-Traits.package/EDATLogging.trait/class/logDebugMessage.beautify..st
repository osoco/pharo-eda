logging
logDebugMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: FileStream stdout
				beautify: aBoolean ]