logging
logErrorMessage: aMessage andThrow: anExceptionClass
	self logErrorMessage: aMessage.
	anExceptionClass signal