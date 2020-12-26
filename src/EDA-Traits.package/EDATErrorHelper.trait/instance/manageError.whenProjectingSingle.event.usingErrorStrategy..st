handling
manageError: exception whenProjectingSingle: aProjection event: anEvent usingErrorStrategy: strategy
	| errorHandler result context |
	context := thisContext clone.
	context at: #error put: exception.
	context at: #event put: anEvent.
	context at: #projection put: aProjection.
	self
		writeFuelContext: context
		named:
			exception class greaseString , '-' , anEvent class greaseString , '-'
				, self class greaseString.
	errorHandler := (self class environment at: strategy asSymbol) new
		context: context.
	result := errorHandler handleError: exception.
	^ result