api
findByIdOfTenant: aTenant ignoringExceptions: anId
	^ self
		findOfTenant: aTenant byId: anId
		withApplyEventsBlock:
			[ :aggregate :events | aggregate applyEventsIgnoringExceptions: events ]