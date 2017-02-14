lifecycle
subscribeToEvents
	self eventListener: EDAEventStompTopicListener new.
	self subscriptionId: self eventListener subscribe.
	self eventsSubscribed: true