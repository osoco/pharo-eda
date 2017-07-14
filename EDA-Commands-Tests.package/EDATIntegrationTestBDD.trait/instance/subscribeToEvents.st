as yet unclassified
subscribeToEvents
	self eventListener: EDAEventStompTopicListener new.
	self subscriptionId: self eventListener subscribe.
	self eventsSubscribed: true.
	Transcript
		print: 'Subscribed to events. subscriptionId is ';
		print: self subscriptionId;
		print: $.;
		cr