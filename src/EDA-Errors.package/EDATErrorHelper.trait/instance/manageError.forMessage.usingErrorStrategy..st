handling
manageError: anException forMessage: aString usingErrorStrategy: aStrategy
	| errorHandler result context basename dictionary |
	self
		logErrorMessage:
			'Error processing ' , aString greaseString , ': '
				, anException description greaseString.
	dictionary := Dictionary new.
	dictionary at: #message put: aString.
	context := thisContext clone.
	basename := self class basename.
	self 
		writeFuelContext: context
		named: anException class greaseString withBasename: basename.
	self writeMessage: aString withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result