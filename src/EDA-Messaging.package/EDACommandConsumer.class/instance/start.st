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
				usingErrorStrategy: EDACommandConsumingErrorBehavior strategy ].
	listener
		on: Error
		do: [ :error | 
			self manageError: error usingErrorStrategy: EDACommandConsumingErrorBehavior strategy.
			self restart ]