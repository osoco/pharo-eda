accessing
lastProjectedEvent
	lastProjectedEvent ifNil: [ lastProjectedEvent := Date new ].
	^ lastProjectedEvent