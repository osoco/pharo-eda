persistence
initBackendRepository
	repository := EDAVOMongoRepository
		host: self class host
		port: self class port
		database: self class databaseName
		username: self class username
		password: self class password.
	self class refreshVoyageSettingsOn: repository
	"repository cache: EDAMongoNoCache new."