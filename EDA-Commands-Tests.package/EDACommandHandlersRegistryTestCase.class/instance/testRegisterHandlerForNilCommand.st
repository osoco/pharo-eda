tests
testRegisterHandlerForNilCommand
	| registry aHandler |
	registry := EDACommandHandlersRegistry emptyRegistry.
	aHandler := protocol mock: 'aHandler'.
	self should: [ registry registerHandler: aHandler command: nil ] raise: EDACommandError