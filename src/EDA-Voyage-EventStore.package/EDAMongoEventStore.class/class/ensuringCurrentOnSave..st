accessing
ensuringCurrentOnSave: aBoolean
	ensuringCurrentOnSave = aBoolean
		ifTrue: [ ^ self ].
	ensuringCurrentOnSave := aBoolean.
	self refreshVoyageSettings