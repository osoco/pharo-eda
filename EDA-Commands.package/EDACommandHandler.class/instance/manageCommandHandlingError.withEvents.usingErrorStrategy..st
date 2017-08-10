handling
manageCommandHandlingError: exception withEvents: producedEvents usingErrorStrategy: strategy
	| errorHandler result |
	errorHandler :=
		(self class environment at: strategy asSymbol) new
			context:
				(Dictionary
					newFrom:
						{(#producedEvents -> producedEvents).
						(#context -> thisContext clone).
						(#stack -> thisContext copyStack)}).
	result := errorHandler handleError: exception.
	^ result