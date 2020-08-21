persistence
removeProjectionOfTenant: aTenant
	self voyageRepository ifNotNil: [ :r | r removeProjection: self ofTenant: aTenant].
	EDAProjectionRemoved new
		projection: self;
		tenant: aTenant;
		emit