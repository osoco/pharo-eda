helper
irregularPresentTenses: aVerb
	| result dict |
	dict := {('built' -> 'build').
	('sent' -> 'send').
	('submitted' -> 'submit')} asDictionary.
	result := dict at: aVerb asLowercase ifAbsent: [ nil ].
	result
		ifNotNil: [ :arg | 
			aVerb = aVerb asUppercase
				ifTrue: [ result := result asUppercase ] ].
	^ result