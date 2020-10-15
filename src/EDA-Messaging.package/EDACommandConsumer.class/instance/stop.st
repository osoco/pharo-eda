lifecycle
stop
	[ self busListener forceUnsubscribe.
	self logWarningMessage: 'Stopped Command Consumer.' ]
		on: Error
		do: [ :ex | 
			self
				logErrorMessage: 'Error stopping Command Consumer: ' , ex description , '.' ]