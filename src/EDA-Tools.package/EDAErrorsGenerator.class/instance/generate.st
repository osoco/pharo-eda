api
generate
	self logDebugMessage: '** Generating error classes for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createInvalidAggregateErrorClass.
	self createAggregateDoesNotExistErrorClass