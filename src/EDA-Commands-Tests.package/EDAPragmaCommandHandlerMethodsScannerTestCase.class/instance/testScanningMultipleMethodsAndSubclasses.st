tests
testScanningMultipleMethodsAndSubclasses
	| aCommandHandlerClass scanner anotherCommandHandlerClass |
	aCommandHandlerClass := self newSubclassOf: aCommandHandlerSuperclass instanceVariableNames: '' classVariableNames: ''.
	anotherCommandHandlerClass := self
		newSubclassOf: aCommandHandlerSuperclass
		instanceVariableNames: ''
		classVariableNames: ''.
	aCommandHandlerClass duringTestCompileSilently: 'handlerCommandMethod: aCommand <pragmaTest: EDACommandClassStub> ^nil'.
	anotherCommandHandlerClass
		duringTestCompileSilently: 'handlerOtherCommandMethod: aCommand <pragmaTest: EDAAnotherCommandClassStub> ^nil'.
	scanner := EDAPragmaCommandHandlerMethodsScanner scannerPragma: #pragmaTest: from: aCommandHandlerSuperclass.
	self
		assert: scanner allCommandHandlerMethods
		equals:
			{(aCommandClass -> (aCommandHandlerClass >> #handlerCommandMethod:)).
			(anotherCommandClass -> (anotherCommandHandlerClass >> #handlerOtherCommandMethod:))} asSet
