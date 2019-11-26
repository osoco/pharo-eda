logging
logWarningMessage: aMessage beautify: aBoolean
	^ EDALoggingSettings warningEnabled
		ifTrue: [ self logMessage: aMessage inCategory: 'WARN ' inStream: FileStream stdout beautify: aBoolean]