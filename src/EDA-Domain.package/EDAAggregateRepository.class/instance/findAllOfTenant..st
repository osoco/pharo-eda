api
findAllOfTenant: aTenant
	^ self
		findAllOfTenant: aTenant withApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]