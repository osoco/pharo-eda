tests
testScanningIfPragmaIsNotInSubclass
	| aCommandHandlerClass scanner |
	aCommandHandlerClass := self newClass.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: EDACommandClassStub> ^2'.
	scanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: (scanner allCommandHandlerMethods)
		equals: nil.
