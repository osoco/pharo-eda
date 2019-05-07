helper
normalize: aString
	^ (aString trimmed replaceAll: '\W' with: '_') asLowercase 