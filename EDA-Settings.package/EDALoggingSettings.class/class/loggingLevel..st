accessing
loggingLevel: aLevel
	| failed |
	failed := true.
	aLevel = 'debug'
		ifTrue: [ self debugEnabled.
			failed := false ].
	aLevel = 'info'
		ifTrue: [ self infoEnabled.
			failed := false ].
	aLevel = 'warning'
		ifTrue: [ self warningEnabled.
			failed := false ].
	aLevel = 'error'
		ifTrue: [ self errorEnabled.
			failed := false ].
	failed ifTrue: [ InvalidLoggingLevel signal ] ifFalse: [ loggingLevel := aLevel ]