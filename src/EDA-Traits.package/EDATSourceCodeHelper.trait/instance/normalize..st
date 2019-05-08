helper
normalize: aString
	^ (aString trimmed replaceAllMatches: '\W' with: '_') asLowercase