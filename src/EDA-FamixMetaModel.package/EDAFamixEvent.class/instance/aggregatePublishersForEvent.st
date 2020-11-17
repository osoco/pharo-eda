view
aggregatePublishersForEvent
	^ self aggregatePublishers
		collect: [ :aggregatePublisher | aggregatePublisher aggregate ]