helper
routingKeyFromDestination: aDestinationString
	^ (aDestinationString findTokens: '/') last.