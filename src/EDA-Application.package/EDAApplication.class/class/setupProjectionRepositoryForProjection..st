setup - projections
setupProjectionRepositoryForProjection: aProjectionClass
	| repository |
	repository := EDAProjectionMongoRepository new.
	self configureProjectionBackendAuthentication: repository.
	aProjectionClass repository: repository