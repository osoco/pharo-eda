handling
manageError: anException whenProjectingEvent: anEvent usingErrorStrategy: aStrategy
	| errorHandler result context basename |
	context := thisContext clone.
	basename := self
		writeFuelContext: context
		named:
			anException class greaseString , '-' , anEvent class greaseString , '-'
				, self class greaseString.
	self writeEvent: anEvent withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler handleError: anException.
	^ result