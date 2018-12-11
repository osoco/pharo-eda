projecting
manageProjectingError: anException withEvent: anEvent andProjections: aProjectionCollection usingErrorStrategy: strategy
	| errorHandler result |
	errorHandler := (self class environment at: strategy asSymbol) new
		context:
			(Dictionary
				newFrom:
					{(#event -> anEvent).
					(#projections -> aProjectionCollection).
					(#context -> thisContext clone).
					(#stack -> thisContext copyStack)}).
	result := errorHandler handleError: anException.
	^ result