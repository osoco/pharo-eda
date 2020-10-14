reading
consumeCommandMessage: aCommandMessageString usingErrorStrategy: strategy
	| aCommand |
	[ Transcript flush.
	aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand ]
		on: Error
		do: [ :error | 
			self manageError: error forCommand: aCommandMessageString usingErrorStrategy: strategy.
			self
				logErrorMessage:
					'Error processing ' , aCommandMessageString greaseString , ': '
						, error description greaseString.
			self restart ]