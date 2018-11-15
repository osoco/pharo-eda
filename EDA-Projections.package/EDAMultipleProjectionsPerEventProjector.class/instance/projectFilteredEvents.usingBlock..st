projection retrieval
projectFilteredEvents: anEventCollection usingBlock: aBlock
	anEventCollection
		doWithIndex: [ :event :index |
			| aProjectionCollection |
			aProjectionCollection := self projectEvent: event atIndex: index ofTotalCount: anEventCollection size.
			aBlock value: aProjectionCollection value: event value: index ]