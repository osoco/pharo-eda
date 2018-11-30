persistence
removeProjection
	repository removeProjection: self.
	EDAProjectionRemoved new
		projection: self;
		emit