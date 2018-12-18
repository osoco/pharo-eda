lifecycle
publishCommand: commandString
	^ EDACommandStompTopicPublisher new publishMessage: commandString