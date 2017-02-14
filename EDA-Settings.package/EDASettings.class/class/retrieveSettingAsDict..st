settings
retrieveSettingAsDict: entryName
	"Retrieves the setting found under given name"
	^ self retrieveSettingAsDict: entryName using: (self DUEnvironmentClass)
