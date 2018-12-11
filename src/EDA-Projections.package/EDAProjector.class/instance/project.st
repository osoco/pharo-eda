api
project
	| projectionSourceEvents |
	self logDebugMessage: 'Projection request for ' , self class projectionClass greaseString , '.'.
	projectionSourceEvents := self sourceEvents: self eventStore.
	self projectEvents: projectionSourceEvents.
	self logDebugMessage: 'End of projection request ' , self class projectionClass greaseString , '.'