helpers
retrieveSettingAsDict: entryName using: env
	"Retrieves the setting found under given name"

	| result |
	result := env at: entryName ifAbsent: [ nil ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]