handling
manageError: anException usingErrorStrategy: aStrategy
	| errorHandler result context basename |
	self
		logErrorMessage: 'Error detected: ' , anException description greaseString.
		basename := self class basename.
	context := thisContext clone.
	self writeFuelContext: context named: anException class greaseString withBasename: basename.
	errorHandler := (self class environment at: aStrategy asSymbol) new
		context: context.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: Dictionary new.
	^ result