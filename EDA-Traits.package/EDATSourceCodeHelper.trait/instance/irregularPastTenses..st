helper
irregularPastTenses: aVerb
	| result dict |
	dict := {('build' -> 'built').
	('send' -> 'sent').
	('submit' -> 'submitted')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg |
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result