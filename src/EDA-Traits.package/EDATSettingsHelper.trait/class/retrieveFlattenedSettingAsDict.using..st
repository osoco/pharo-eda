helpers
retrieveFlattenedSettingAsDict: entryName using: env
	"Retrieves the setting found under given name"

	| result |
	result := env ifNil: [ nil ] ifNotNil: [ :e | e at: entryName ifAbsent: [ nil ] ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]