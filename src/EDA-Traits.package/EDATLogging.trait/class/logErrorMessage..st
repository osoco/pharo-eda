logging
logErrorMessage: aMessage
	EDALoggingSettings errorEnabled ifTrue: [ 
	self logMessage: aMessage inCategory: 'ERROR' inStream: FileStream stderr ]