lifecycle
restart
	self logWarningMessage: 'Restarting Command Consumer...'.
	[ self stop ]
		ensure: [ self start ]