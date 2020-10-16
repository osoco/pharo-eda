reading
consumeCommandMessage: aCommandMessageString
	| aCommand |
	aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand