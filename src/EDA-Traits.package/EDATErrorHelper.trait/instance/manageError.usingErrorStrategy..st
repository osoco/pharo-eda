handling
manageError: exception usingErrorStrategy: strategy
	| errorHandler result context |
	context := thisContext clone.
	self writeFuelContext: context named: exception class greaseString.
	errorHandler := (self class environment at: strategy asSymbol) new
		context: context.
	result := errorHandler handleError: exception.
	^ result