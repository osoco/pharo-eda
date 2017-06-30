as yet unclassified
unsubscribeToEvents
	self eventsSubscribed
		ifTrue: [
			self unsubscribe: self subscriptionId usingListener: self eventListener.
			self eventsSubscribed: false ]
		ifFalse: [
			Transcript
				print: 'Already unsubscribed to events.';
				cr ]