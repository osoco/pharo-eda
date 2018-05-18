api
findByIdIgnoringExceptions: anId
	^ self findById: anId withApplyEventsBlock: [ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]