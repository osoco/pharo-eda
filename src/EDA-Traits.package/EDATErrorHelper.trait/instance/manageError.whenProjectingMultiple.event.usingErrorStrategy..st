handling
manageError: exception whenProjectingMultiple: aProjectionCollection event: anEvent usingErrorStrategy: strategy
	| errorHandler result context |
	context := thisContext clone.
	context at: #error put: exception.
	context at: #event put: anEvent.
	context at: #projections put: aProjectionCollection.
	self
		writeFuelContext: context
		named:
			exception class greaseString , '-' , anEvent class greaseString , '-'
				, self class greaseString.
	errorHandler := (self class environment at: strategy asSymbol) new
		context: context.
	result := errorHandler handleError: exception.
	^ result