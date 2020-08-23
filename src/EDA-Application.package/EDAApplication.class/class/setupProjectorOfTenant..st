setup - projections
setupProjectorOfTenant: aTenant
	self
		projectorsByTenant at: aTenant put: 
			(EDACompositeProjector
				ofTenant: aTenant
				withAllProjectorsAndEventStore: self eventStore)