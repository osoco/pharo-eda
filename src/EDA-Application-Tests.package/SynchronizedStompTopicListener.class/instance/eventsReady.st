accessing
eventsReady
	eventsReady == nil
		ifTrue: [ self eventsReady: false ].
	^ eventsReady