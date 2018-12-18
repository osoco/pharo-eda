accessing
numProjectedEvents
	numProjectedEvents ifNil: [ numProjectedEvents := 0 ].
	^ numProjectedEvents