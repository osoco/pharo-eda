accessing
lastResponse
	| response |
	response := super lastResponse.
	self logDebugMessage: response greaseString.
	^ response