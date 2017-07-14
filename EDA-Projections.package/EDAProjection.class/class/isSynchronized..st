projection
isSynchronized: projectionSourceEvents
	| isSynchronized totalProjectedEventsSize |
	totalProjectedEventsSize := self totalProjectedEvents.
	isSynchronized := projectionSourceEvents size <= totalProjectedEventsSize.
	EDAProjectionSynchronizationChecked new
		projection: self;
		synchronized: isSynchronized;
		projectionSourceEventsSize: projectionSourceEvents size;
		totalProjectedEventsSize: totalProjectedEventsSize;
		emit.
	^ isSynchronized