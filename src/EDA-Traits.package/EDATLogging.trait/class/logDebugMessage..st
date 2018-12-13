logging
logDebugMessage: aMessage
	EDALoggingSettings debugEnabled
		ifTrue: [ self logMessage: aMessage inCategory: 'DEBUG' inStream: self defaultStream ]