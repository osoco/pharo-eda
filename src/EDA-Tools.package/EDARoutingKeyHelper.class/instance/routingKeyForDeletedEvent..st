helper
routingKeyForDeletedEvent: anEvent
	^ (EDAMessageSerializer nameWithoutPrefixForMessageClass: anEvent aggregateRootClass) asLowercase , '.deleted'