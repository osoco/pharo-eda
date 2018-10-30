lifecycle
subscribeToEvents
	self eventListener: EDAEventStompTopicListener new.
	self subscriptionId: self eventListener subscribe.
	self eventsSubscribed: true.
	self
		logInfoMessage: 'Subscribed to events. subscriptionId is ' , self subscriptionId greaseString , '.'