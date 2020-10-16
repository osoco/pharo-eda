error handling
handleError: anException withExtraContextInformation: aDictionary
	anException freeze.
	self class annotateError: anException.
	anException signal.
	^ true