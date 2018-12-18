projecting
manageProjectingError: anException withEvent: anEvent andProjection: aProjection usingErrorStrategy: strategy
	| errorHandler result |
	aProjection unprojectedEvents add: anEvent.
	aProjection save.
	errorHandler := (self class environment at: strategy asSymbol) new
		context:
			(Dictionary
				newFrom:
					{(#event -> anEvent).
					(#projection -> aProjection).
					(#context -> thisContext clone).
					(#stack -> thisContext copyStack)}).
	result := errorHandler handleError: anException.
	^ result