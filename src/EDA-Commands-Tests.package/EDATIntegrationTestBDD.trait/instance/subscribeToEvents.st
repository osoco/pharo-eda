lifecycle
subscribeToEvents
	self eventListener: EDATestEventStompTopicListener new.
	self subscriptionId: self eventListener subscribe.
	self eventsSubscribed: true.
	self logInfoMessage: 'Subscribed to events. subscriptionId is ' , self subscriptionId greaseString , '.'