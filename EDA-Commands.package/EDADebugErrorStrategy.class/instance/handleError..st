error handling
handleError: error
	| result |
	result := self context at: #producedEvents ifAbsent: OrderedCollection new.
	error freeze.
	self class annotateError: error.
	^ result