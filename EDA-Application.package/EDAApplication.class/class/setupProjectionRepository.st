initialization
setupProjectionRepository
	| repository |
	repository := EDAProjectionMongoRepository new.
	EDAProjection repository: repository.
