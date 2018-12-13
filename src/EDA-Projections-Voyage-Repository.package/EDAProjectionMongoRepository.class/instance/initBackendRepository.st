persistence
initBackendRepository
	repository := EDAVOProjectionMongoRepository
		host: self class host
		port: self class port
		database: self class databaseName
		username: self class username
		password: self class password.
	self class refreshVoyageSettingsOn: repository