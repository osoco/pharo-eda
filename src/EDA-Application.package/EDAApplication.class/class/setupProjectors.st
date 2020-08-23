setup - projections
setupProjectors
	self retrieveAllTenants do: [ :tenant | self setupProjectorOfTenant: tenant ]