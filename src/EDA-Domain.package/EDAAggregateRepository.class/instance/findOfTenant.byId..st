api
findOfTenant: aTenant byId: anId
	^ self
		findOfTenant: aTenant byId: anId
		withApplyEventsBlock: [ :aggregate :events | aggregate applyEvents: events ]