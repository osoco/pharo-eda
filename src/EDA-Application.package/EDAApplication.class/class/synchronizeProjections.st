setup - projections
synchronizeProjections
	self retrieveAllTenants do: [ :tenant | 
	self projector projectOfTenant: tenant ]