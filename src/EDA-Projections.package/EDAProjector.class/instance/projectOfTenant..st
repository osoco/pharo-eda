api
projectOfTenant: aTenant
	| projectionSourceEvents |
	(self class synchronizationInProgressOfTenant: aTenant)
		ifTrue: [ ^ self ].
	self class synchronizationInProgressOfTenant: aTenant is: true.
	self
		logDebugMessage:
			'Projection request for ' , self class projectionClass greaseString
				, '.'.
	projectionSourceEvents := self sourceEvents: self eventStore ofTenant: aTenant.
	self projectEvents: projectionSourceEvents ofTenant: aTenant.
	self
		logDebugMessage:
			'End of projection request ' , self class projectionClass greaseString
				, '.'.
	self class synchronizationInProgress: false ofTenant: aTenant