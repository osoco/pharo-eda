reading
consumeCommandMessage: aCommandMessageString
	| aCommand |
	[ aCommand := self commandMaterializer materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand ]
	on: Error
	do: [ :error | 
			self logErrorMessage: 'Error processing ' , aCommandMessageString, ': ', error description greaseString, '.'.
			self restart ]