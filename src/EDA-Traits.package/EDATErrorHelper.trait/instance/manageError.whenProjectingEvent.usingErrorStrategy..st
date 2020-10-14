handling
manageError: anException whenProjectingEvent: anEvent usingErrorStrategy: aStrategy
	| errorHandler result context basename dictionary |
	context := thisContext clone.
	basename := self
		writeFuelContext: context
		named:
			anException class greaseString , '-' , anEvent class greaseString
				, '-' , self class greaseString.
	self writeEvent: anEvent withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	dictionary := Dictionary new.
	dictionary at: #event put: anEvent.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result