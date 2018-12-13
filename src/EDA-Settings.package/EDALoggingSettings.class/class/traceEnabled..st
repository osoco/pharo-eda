accessing
traceEnabled: aBoolean
	traceEnabled := aBoolean.
	aBoolean
		ifTrue: [ self debugEnabled: true ]