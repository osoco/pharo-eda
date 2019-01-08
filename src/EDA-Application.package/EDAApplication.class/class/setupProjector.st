setup - projections
setupProjector
	self projector: (EDACompositeProjector withAllProjectorsAndEventStore: self eventStore)