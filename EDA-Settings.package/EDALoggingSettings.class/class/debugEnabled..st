accessing
debugEnabled: aBoolean
	debugEnabled := aBoolean.
	aBoolean ifTrue: [ self infoEnabled: true ]