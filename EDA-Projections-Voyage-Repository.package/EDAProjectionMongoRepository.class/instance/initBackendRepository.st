persistence
initBackendRepository
	repository := VOMongoRepository
		host: EDAProjectionMongoRepository host
		port: EDAProjectionMongoRepository port
		database: EDAProjectionMongoRepository databaseName
		username: EDAProjectionMongoRepository username
		password: EDAProjectionMongoRepository password.
		"repository cache: EDAMongoNoCache new."
	repository enableSingleton
