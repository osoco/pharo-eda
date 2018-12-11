api
findAllIgnoringExceptions
	^ self findAllWithApplyEventsBlock: [ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]