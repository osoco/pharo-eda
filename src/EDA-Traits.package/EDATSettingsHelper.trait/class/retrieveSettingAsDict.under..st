helpers
retrieveSettingAsDict: entryName under: aKey
	"Retrieves the setting found under given name"

	| settings |
	settings := self retrieveSettingAsDict: aKey using: self duEnvironmentClass.
	^ settings at: entryName ifAbsent: [ nil ]