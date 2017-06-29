as yet unclassified
unsubscribeToEvents
	Transcript
		print: 'Unsubscribing to events (eventsSubscribed is ';
		print: self eventsSubscribed;
		print: ').';
		cr.
	self eventsSubscribed
		ifTrue: [ Transcript
				print: 'eventsSubscribed is true. subscriptionId is ';
				print: self subscriptionId;
				print: $.;
				cr.
			self unsubscribe: self subscriptionId usingListener: self eventListener.
			self eventsSubscribed: false ]
		ifFalse: [ Transcript
				print: 'Not unsubscribing to events.';
				cr ]