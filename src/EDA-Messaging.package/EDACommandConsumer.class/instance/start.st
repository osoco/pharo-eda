lifecycle
start
	| listener |
	self logWarningMessage: 'Starting Command Consumer..'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | 
			Transcript flush.
			self
				consumeCommandMessage: message
				usingErrorStrategy: self class errorStrategy ].
	listener
		on: Error
		do: [ :error | 
			self manageError: error usingErrorStrategy: self class errorStrategy.
			self restart ]