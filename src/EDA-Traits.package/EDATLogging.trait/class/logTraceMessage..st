logging
logTraceMessage: aMessage
	EDALoggingSettings traceEnabled
		ifTrue: [ self logMessage: aMessage inCategory: 'TRACE' inStream: self defaultStream ]