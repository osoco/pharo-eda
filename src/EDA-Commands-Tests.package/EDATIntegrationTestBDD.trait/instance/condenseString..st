helper
condenseString: aString
	^ aString withBlanksCondensed select: [ :char | (char = Character cr or: [ char = Character lf ]) not ]