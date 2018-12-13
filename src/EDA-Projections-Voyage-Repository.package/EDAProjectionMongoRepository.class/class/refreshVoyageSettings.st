refresh settings
refreshVoyageSettings
	EDAVOProjectionMongoRepository allInstancesDo: [ :repo | self refreshVoyageSettingsOn: repo ]