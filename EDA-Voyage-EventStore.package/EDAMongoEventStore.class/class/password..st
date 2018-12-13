accessing
password: anObject
	password = anObject
		ifTrue: [ ^ self ].
	password := anObject.
	self refreshVoyageSettings