logging
logWarningMessage: aMessage
	EDALoggingSettings warningEnabled ifTrue: [ 
	self logMessage: aMessage inCategory: 'WARN ' inStream: FileStream stdout ]