persistence
removeProjection
	Repository removeProjection: self.
	EDAProjectionRemoved new
		projection: self;
		emit