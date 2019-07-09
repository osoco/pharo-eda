reading
consumeCommandMessage: aCommandMessageString
	| aCommand |
	[ aCommand := self commandMaterializer materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand ]
		on: Error
		do: [ :error | 
			self logErrorMessage: 'Error processing ' , aCommandMessageString greaseString , ': ' , error description greaseString , '.'.
			self logErrorMessage: 'Consumer: ', self greaseString , '.'.
			self restart ]