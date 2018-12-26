accessing
debug: aBoolean
	debug = aBoolean
		ifTrue: [ ^ self ].
	debug := aBoolean.
	self refreshVoyageSettings