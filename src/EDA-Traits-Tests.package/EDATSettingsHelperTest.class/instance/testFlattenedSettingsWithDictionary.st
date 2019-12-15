tests
testFlattenedSettingsWithDictionary
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> 'e')} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c' using: env.
	self assert: (actual at: 'd' ifAbsent: nil) equals: 'e'