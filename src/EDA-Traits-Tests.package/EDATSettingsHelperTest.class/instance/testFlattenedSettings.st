tests
testFlattenedSettings
	| actual env |
	env := {('a' -> 'b')} asDictionary.
	actual := self class retrieveSettingAsDict: 'a' using: env.
	self assert: actual equals: 'b'