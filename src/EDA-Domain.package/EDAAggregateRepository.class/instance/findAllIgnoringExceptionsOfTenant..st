api
findAllIgnoringExceptionsOfTenant: aTenant
	^ self
		findAllOfTenant: aTenant withApplyEventsBlock:
			[ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]