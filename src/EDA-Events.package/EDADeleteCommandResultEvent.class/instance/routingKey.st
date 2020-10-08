messaging
routingKey
	^ (EDAMessageSerializer nameWithoutPrefixForMessageClass: self aggregateRootClass) asLowercase , '.deleted'