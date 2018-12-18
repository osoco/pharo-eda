accessing
infoEnabled: aBoolean
	infoEnabled := aBoolean.
	aBoolean ifTrue: [ self warningEnabled: true ].