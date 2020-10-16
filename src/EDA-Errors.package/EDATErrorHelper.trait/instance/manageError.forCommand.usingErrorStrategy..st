handling
manageError: anException forCommand: aCommand usingErrorStrategy: aStrategy
	| errorHandler result context basename dictionary |
		self
		logErrorMessage:
			'Error processing ' , aCommand greaseString , ': '
				, anException description greaseString.
	context := thisContext clone.
	basename := self class basename.
	self
		writeFuelContext: context
		named: anException class greaseString
		withBasename: basename.
	self writeCommand: aCommand withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	dictionary := Dictionary new.
	dictionary at: #command put: aCommand.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result