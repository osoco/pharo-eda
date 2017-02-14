tests
testCreateRegistryWithScannerAndFactory
	| aScanner aFactory registry aCommand aCommandHandler aHandlerMethod |
	aScanner := protocol mock: 'aScanner'.
	aFactory := protocol mock: 'aFactory'.
	aCommand := protocol mock: 'aCommand'.
	aHandlerMethod := protocol mock: 'aHandlerMethod'.
	aCommandHandler := protocol mock: 'aCommandHandler'.
	protocol describe
		once: aScanner recv: #allCommandHandlerMethods;
		=> {(aCommand class -> aHandlerMethod)}.
	protocol describe
		once: aFactory recv: #newFromHandlerMethod:;
		with: aHandlerMethod;
		=> aCommandHandler.
	registry := EDACommandHandlersRegistry withScanner: aScanner factory: aFactory.
	self assert: (registry handlerForCommand: aCommand) equals: aCommandHandler