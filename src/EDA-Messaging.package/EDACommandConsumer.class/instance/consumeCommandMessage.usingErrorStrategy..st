reading
consumeCommandMessage: aCommandMessageString usingErrorStrategy: strategy
	| aCommand |
	[ Transcript flush.
	aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand ]
		on: Exception
		do: [ :error |
			self
				manageError: error
				forMessage: aCommandMessageString
				usingErrorStrategy: strategy
			self restart ]