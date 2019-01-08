reset - projections
resetProjector
	self projector ifNotNil: [ :p | p class synchronizationInProgress: false ].
	self projector: nil