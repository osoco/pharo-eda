setup - projections
synchronizeProjections
	self retrieveAllTenants
		do: [ :tenant | 
			| projector |
			projector := self projectorsByTenant at: tenant ifAbsent: [ nil ].
			projector ifNotNil: [ :p | p projectOfTenant: tenant ] ]