bdd
unsubscribeToEvents
	self eventsSubscribed
		ifTrue: [
			self unsubscribe: self subscriptionId usingListener: self eventListener.
			self eventsSubscribed: false ]
		ifFalse: [
			self logDebugMessage: 'Already unsubscribed to events.']
