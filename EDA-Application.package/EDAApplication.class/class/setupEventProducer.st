initialization
setupEventProducer
	| eventPublisher eventSerializer |
	eventPublisher := EDAEventStompTopicPublisher new.
	eventSerializer := EDAJsonEventSerializer new.
	self eventProducer: (EDAEventProducer publisher: eventPublisher serializer: eventSerializer)