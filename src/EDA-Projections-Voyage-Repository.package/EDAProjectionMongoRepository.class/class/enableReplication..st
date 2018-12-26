accessing
enableReplication: aBoolean
	enableReplication = aBoolean
		ifTrue: [ ^ self ].
	enableReplication := aBoolean.
	self refreshVoyageSettings