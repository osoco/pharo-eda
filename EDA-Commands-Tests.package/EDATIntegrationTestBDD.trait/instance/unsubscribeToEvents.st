as yet unclassified
unsubscribeToEvents
	self eventsSubscribed ifTrue: [
		self unsubscribe: self subscriptionId usingListener: self listener.
		self eventsSubscribed: false
	]