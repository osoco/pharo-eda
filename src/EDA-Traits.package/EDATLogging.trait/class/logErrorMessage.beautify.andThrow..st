logging
logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass
	self logErrorMessage: aMessage beautify: aBoolean.
	anExceptionClass signal