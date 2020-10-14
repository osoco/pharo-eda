handling
manageError: anException forMessage: aString usingErrorStrategy: aStrategy
	| errorHandler result context basename |
				self
				logErrorMessage:
					'Error processing ' , aString greaseString , ': '
						, anException description greaseString.
	context := thisContext clone.
	basename := self
		writeFuelContext: context
		named: anException class greaseString.
	self writeMessage: aString withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler handleError: anException.
	^ result