handling
manageError: anException whenProjectingEvent: anEvent usingErrorStrategy: aStrategy
	| errorHandler result context basename dictionary |
		self
		logErrorMessage:
			'Error projecting ' , anEvent greaseString , ': '
				, anException description greaseString.
	context := thisContext clone.
	basename := self class basename.
	self
		writeFuelContext: context
		named:
			anException class greaseString , '-' , anEvent class greaseString
				, '.txt'
		withBasename: basename.
	self writeEvent: anEvent withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	dictionary := Dictionary new.
	dictionary at: #event put: anEvent.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result