lifecycle
publishCommand: commandString
	^ self commandStompTopicPublisher publishMessage: commandString