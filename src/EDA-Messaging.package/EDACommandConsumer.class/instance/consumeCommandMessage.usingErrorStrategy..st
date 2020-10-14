reading
consumeCommandMessage: aCommandMessageString usingErrorStrategy: aStrategy
	| aCommand |
	[ aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand ]
		on: Exception
		do: [ :error |
			self
				manageError: error
				forMessage: aCommandMessageString
				usingErrorStrategy: aStrategy. self restart ]