helper
routingKeyFor: anEvent
	^ (	anEvent class = EDADeleteCommandResultEvent)
		ifTrue: [
			self routingKeyForDeletedEvent: anEvent
		] ifFalse: [
			self routingKeyForEventSourcingEvent: anEvent
		]