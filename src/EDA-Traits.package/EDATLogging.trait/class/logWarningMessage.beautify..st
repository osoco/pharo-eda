logging
logWarningMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]