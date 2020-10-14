lifecycle
start
	| listener |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | 
			self
				consumeCommandMessage: message
				usingErrorStrategy: EDACommandConsumingErrorBehavior strategy ].
	listener
		on: Exception
		do: [ :error | 
			self
				manageError: error
				usingErrorStrategy: EDACommandConsumingErrorBehavior strategy.
			self restart ]