logging
logInfoMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: FileStream stdout
				beautify: aBoolean ]