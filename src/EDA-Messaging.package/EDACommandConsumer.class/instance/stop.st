lifecycle
stop
	self logWarningMessage: 'Stopping Command Consumer (' , self greaseString , ') ...'.
	[ self busListener forceUnsubscribe ]
		on: Error
		do: [ :ex | self logErrorMessage: 'Error stopping Command Consumer: ' , ex description , '.' ]