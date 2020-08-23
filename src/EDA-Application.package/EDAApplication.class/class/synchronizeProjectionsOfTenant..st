setup - projections
synchronizeProjectionsOfTenant: aTenant
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector ifNotNil: [ :p | p projectOfTenant: aTenant ]