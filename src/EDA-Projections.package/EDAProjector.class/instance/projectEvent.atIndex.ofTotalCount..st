projecting
projectEvent: anEvent atIndex: anIndex ofTotalCount: aCount
	^ self
		projectEvent: anEvent
		usingEmittingBlock: [ :eventToEmit |
			eventToEmit
				index: anIndex;
				projectionSourceEventsSize: aCount ]