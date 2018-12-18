logging
logInfoMessage: aMessage
	EDALoggingSettings infoEnabled ifTrue: [ 
	self logMessage: aMessage inCategory: 'INFO ' inStream: FileStream stdout ]