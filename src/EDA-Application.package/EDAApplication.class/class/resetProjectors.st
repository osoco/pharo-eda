reset - projections
resetProjectors
	self retrieveAllTenants do: [ :t | self resetProjectorOfTenant: t ]

