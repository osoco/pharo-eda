registry
registerHandler: aCommandHandler command: aCommand
	aCommand ifNil: [ EDACommandError signal ].
	self handlers at: aCommand class put: aCommandHandler