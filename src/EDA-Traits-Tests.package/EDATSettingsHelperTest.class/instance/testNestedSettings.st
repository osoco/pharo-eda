tests
testNestedSettings
	| actual env |
	env := {('a' -> 'b').
	('c' -> {('d' -> {('e' -> 'f')} asDictionary)} asDictionary)} asDictionary.
	actual := self class retrieveSettingAsDict: 'c/d' using: env.
	self assert: (actual at: 'e' ifAbsent: nil) equals: 'f'