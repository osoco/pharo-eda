helper
toCamelCase: aString
	| aux |
	aux := '_' asRegexIgnoringCase copy: aString replacingMatchesWith: ' '.
	^ aux asLowercase asCamelCase