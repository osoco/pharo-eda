persistence
removeProjection
	self voyageRepository ifNotNil: [ :r | r removeProjection: self ].
	EDAProjectionRemoved new
		projection: self;
		emit