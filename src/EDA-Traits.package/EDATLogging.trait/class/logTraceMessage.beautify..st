logging
logTraceMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]