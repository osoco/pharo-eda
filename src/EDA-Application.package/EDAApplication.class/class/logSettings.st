logging
logSettings
	self logInfoMessage: 'Command consumer: ' , self commandConsumer greaseString.
	self logInfoMessage: 'Command dispatcher: ' , self commandDispatcher greaseString.
	self logInfoMessage: 'Command listener client debug: ' , self commandListenerClientDebug greaseString.
	self logInfoMessage: 'Event announcer: ' , self eventAnnouncer greaseString.
	self logInfoMessage: 'Event producer: ' , self eventProducer greaseString.
	self logInfoMessage: 'Event store: ' , self eventStore greaseString.
	self logInfoMessage: 'Projection synchronization enabled: ' , self projectionSynchronizationEnabled greaseString.
	self logInfoMessage: 'Projector: ' , self projector greaseString