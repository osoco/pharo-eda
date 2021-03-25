persistence
initBackendRepository
	| result |
	result := EDAVOMongoRepository
		host: self class host
		port: self class port
		database: self class databaseName
		username: self class username
		password: self class password.
	"result cache: EDAMongoNoCache new."
	result debug: self class debug.
	self class enableSingleton
		ifTrue: [ result enableSingleton ]
		ifFalse: [ result disableSingleton ].
	result ensuringCurrentOnSave: self class ensuringCurrentOnSave.
	result ensuringCurrentReferencesOnQueries: self class ensuringCurrentReferencesOnQueries.
"	result forceEager: self class forceEager."
	result lazySynchronize: self class lazySynchronize.
	^ result
