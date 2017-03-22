helper
irregularPastTenses: aVerb
	| result dict |
	dict := {('build' -> 'built')} asDictionary.
	result := dict at: aVerb ifAbsent: [ nil ].
	^ result