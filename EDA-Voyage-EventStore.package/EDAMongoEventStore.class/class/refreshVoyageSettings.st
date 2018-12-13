refresh settings
refreshVoyageSettings
	EDAVOMongoRepository
		allInstancesDo: [ :repo | self refreshVoyageSettingsOn: repo ]