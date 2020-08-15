checks
isSynchronized: projectionSourceEvents ofTenant: aTenant
	| isSynchronized totalProjectedEventsSize |
	self
		logDebugMessage:
			'Checking if ' , self class projectionClass name greaseString
				, ' requires synchronization.'.
	totalProjectedEventsSize := self totalProjectedEventsOfTenant: aTenant.
	isSynchronized := projectionSourceEvents size
		<= totalProjectedEventsSize.
	EDAProjectionSynchronizationChecked new
		projection: self;
		synchronized: isSynchronized;
		projectionSourceEventsSize: projectionSourceEvents size;
		totalProjectedEventsSize: totalProjectedEventsSize;
		emit.
	isSynchronized
		ifTrue: [ self
				logDebugMessage:
					self class projectionClass name greaseString
						, ' already synchronized.' ]
		ifFalse: [ self
				logDebugMessage:
					self class projectionClass name greaseString
						, ' needs synchronization ('
						, totalProjectedEventsSize greaseString , '/'
						, projectionSourceEvents size greaseString , ').' ].
	^ isSynchronized