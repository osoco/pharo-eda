handling
manageError: anException usingErrorStrategy: aStrategy
	| errorHandler result context |
	self
		logErrorMessage:
			'Error in Command Consumer''s listener: '
				, anException description greaseString.
	context := thisContext clone.
	self writeFuelContext: context named: anException class greaseString.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler handleError: anException withExtraContextInformation: Dictionary new.
	^ result