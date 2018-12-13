error handling
handleError: anException

	anException freeze.
	self class annotateError: anException.
	^ true
