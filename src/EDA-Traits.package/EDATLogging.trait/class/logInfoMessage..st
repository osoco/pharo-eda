logging
logInfoMessage: aMessage
	EDALoggingSettings infoEnabled
		ifTrue: [ self logMessage: aMessage inCategory: 'INFO ' inStream: self stdout ]