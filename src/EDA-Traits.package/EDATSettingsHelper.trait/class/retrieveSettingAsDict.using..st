helpers
retrieveSettingAsDict: entryName using: env
	"Retrieves the setting found under given name"

	| result |
	(entryName includes: $/)
		ifTrue: [ | tokens parent |
			tokens := '/' split: entryName.
			parent := tokens first.
			result := self retrieveFlattenedSettingAsDict: (tokens allButFirst joinUsing: '/') using: (self retrieveFlattenedSettingAsDict: parent using: env) ]
		ifFalse: [ result := self retrieveFlattenedSettingAsDict: entryName using: env ].
	result ifNil: [ ^ Dictionary new ] ifNotNil: [ :r | ^ r ]