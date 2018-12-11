api
findAll
	^ self findAllWithApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]