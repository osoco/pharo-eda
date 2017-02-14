tests
testScanning
	| aCommandHandlerClass scanner |
	aCommandHandlerClass := self newSubclassOf: aCommandHandlerSuperclass instanceVariableNames: '' classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: GCCommandClassStub> ^2'.
	scanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: (scanner allCommandHandlerMethods)
		equals: {(aCommandClass -> (aCommandHandlerClass >> #handlerCommandMethod:))} asSet