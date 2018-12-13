accessing
warningEnabled: aBoolean
	warningEnabled := aBoolean.
	aBoolean
		ifTrue: [ self errorEnabled: true ]