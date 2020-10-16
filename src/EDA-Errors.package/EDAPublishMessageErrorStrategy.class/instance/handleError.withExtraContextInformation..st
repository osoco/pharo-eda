error handling
handleError: anError withExtraContextInformation: aDictionary
	| serializer message |
	serializer := EDAJsonErrorSerializer
		withContext: thisContext clone
		andExtraContextInformation: aDictionary.
	message := serializer serialize: anError greaseString.
	EDAEventStompTopicPublisher new publishError: message