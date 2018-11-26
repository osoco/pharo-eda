logging
logErrorMessage: aMessage
	self logMessage: aMessage inCategory: 'ERROR' inStream: FileStream stderr
