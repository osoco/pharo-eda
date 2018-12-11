api
findById: anId
	^ self findById: anId withApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]