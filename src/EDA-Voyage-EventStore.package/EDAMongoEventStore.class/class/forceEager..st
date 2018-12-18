accessing
forceEager: aBoolean
	forceEager = aBoolean
		ifTrue: [ ^ self ].
	forceEager := aBoolean.
	self refreshVoyageSettings