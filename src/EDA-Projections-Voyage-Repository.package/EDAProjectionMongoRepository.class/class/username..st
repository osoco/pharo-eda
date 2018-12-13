accessing
username: anObject
	username = anObject
		ifTrue: [ ^ self ].
	username := anObject.
	self refreshVoyageSettings