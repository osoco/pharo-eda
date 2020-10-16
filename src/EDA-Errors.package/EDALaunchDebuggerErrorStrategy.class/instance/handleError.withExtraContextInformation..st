error handling
handleError: anException withExtraContextInformation: aDictionary
	anException freeze.
	self class annotateError: anException.
	Break signal.
	^ true