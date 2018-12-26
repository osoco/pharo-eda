accessing
enableSingleton: aBoolean
	enableSingleton = aBoolean
		ifTrue: [ ^ self ].
	enableSingleton := aBoolean.
	self refreshVoyageSettings