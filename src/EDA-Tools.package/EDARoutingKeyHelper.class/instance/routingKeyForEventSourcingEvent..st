helper
routingKeyForEventSourcingEvent: anEvent
	^ 	self camelCaseToDotSeparated: (EDAMessageSerializer nameWithoutPrefixForMessageClass: anEvent class)