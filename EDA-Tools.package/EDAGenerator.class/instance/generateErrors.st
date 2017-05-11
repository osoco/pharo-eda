api
generateErrors
	Transcript
		print: 'Generating: Errors';
		cr.
	self createInvalidAggregateErrorClass.
	self createAggregateDoesNotExistErrorClass.