lifecycle
start
	| listener |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | self consumeCommandMessage: message ].
	listener
		on: Error
		do: [ :error | 
			self logErrorMessage: 'Error in Command Consumer''s listener: ', error description, '.'.
			self restart ]