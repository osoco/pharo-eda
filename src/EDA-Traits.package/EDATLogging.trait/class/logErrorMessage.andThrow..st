logging
logErrorMessage: aMessage andThrow: anExceptionClass
	^ self logErrorMessage: aMessage beautify: self beautifyByDefault andThrow: anExceptionClass