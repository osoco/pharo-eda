error handling
handleError: anError withxtraContextInformation: aDictionary
	| serializer message |
	serializer := EDAJsonErrorSerializer
		withContext: thisContext clone
		andExtraContextInformation: aDictionary.
	message := serializer serialize: anError.
	EDAEventStompTopicPublisher new
		publishMessage: message
		withRoutingKey: 'error-messages-from-core'