logging
logSettings
	self
		logDebugMessage: 'Command consumer: ' , self commandConsumer greaseString.
	self
		logDebugMessage: 'Command dispatcher: ' , self commandDispatcher greaseString.
	self
		logDebugMessage:
			'Command listener client debug: '
				, self commandListenerClientDebug greaseString.
	self
		logDebugMessage: 'Event announcer: ' , self eventAnnouncer greaseString.
	self
		logDebugMessage: 'Event producer: ' , self eventProducer greaseString.
	self logDebugMessage: 'Event store: ' , self eventStore greaseString.
	self
		logDebugMessage:
			'Projection synchronization enabled: '
				, self projectionSynchronizationEnabled greaseString.
	self
		logDebugMessage: 'Projectors: ' , self projectorsByTenant greaseString