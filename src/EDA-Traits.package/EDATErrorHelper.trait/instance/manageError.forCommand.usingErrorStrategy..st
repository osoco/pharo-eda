handling
manageError: anException forCommand: aCommand usingErrorStrategy: aStrategy
	| errorHandler result context basename dictionary |
	context := thisContext clone.
	basename := self
		writeFuelContext: context
		named: anException class greaseString.
	self writeCommand: aCommand withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	dictionary := Dictionary new.
	dictionary at: #command put: aCommand.
	result := errorHandler handleError: anException withExtraContextInformation: dictionary.
	^ result