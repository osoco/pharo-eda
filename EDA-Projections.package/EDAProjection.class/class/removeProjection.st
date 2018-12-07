persistence
removeProjection
	repository ifNotNil: [ :r | r removeProjection: self ].
	EDAProjectionRemoved new
		projection: self;
		emit