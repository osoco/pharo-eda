initialization
setupProjectionRepository
	| repository |
	self flag: #TODO.
	repository := EDAProjectionMongoRepository new.
	EDAProjection repository: repository.
