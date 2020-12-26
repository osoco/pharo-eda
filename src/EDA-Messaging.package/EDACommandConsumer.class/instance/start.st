lifecycle
start
	| listener |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | 
			self
				consumeCommandMessage: message ].
	listener
		on: Exception - Break
		do: [ :error | 
			self manageError: error usingErrorStrategy: self class errorStrategy.
			self
				logErrorMessage:
					'Error in Command Consumer''s listener: '
						, error description greaseString.
			self restart ]
