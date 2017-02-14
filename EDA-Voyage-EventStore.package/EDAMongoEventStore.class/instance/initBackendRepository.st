initialization
initBackendRepository
	repository := VOMongoRepository
		host: EDAMongoEventStore host
		port: EDAMongoEventStore port
		database: EDAMongoEventStore databaseName
		username: EDAMongoEventStore username
		password: EDAMongoEventStore password.
	repository cache: EDAMongoNoCache new.
	repository enableSingleton.
