helper
normalize: aString
	^ (self replace: '\W' with: '_' inString: aString trimmed) asLowercase