setup
setupProjectionRepositoryForProjection: aProjectionClass
	| repository |
	repository := EDAProjectionMongoRepository new.
	aProjectionClass repository: repository