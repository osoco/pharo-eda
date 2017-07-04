projection
isSynchronized: projectionSourceEvents
	| isSynchronized |
	isSynchronized := projectionSourceEvents size <= self totalProjectedEvents.
	EDAProjectionSynchronizationChecked new
		projection: self;
		synchronized: isSynchronized;
		projectionSourceEventsSize: projectionSourceEvents size;
		emit.
	^ isSynchronized