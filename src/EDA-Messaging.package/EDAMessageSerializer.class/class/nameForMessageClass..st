parsing
nameForMessageClass: aMessageClass
	^ ((self nameWithoutPrefixForMessageClass: aMessageClass)
		copyWithRegex: '([A-Z]+)([a-z]+)'
		matchesTranslatedUsing: [ :each | each asString , '_' ]) allButLast asUppercase