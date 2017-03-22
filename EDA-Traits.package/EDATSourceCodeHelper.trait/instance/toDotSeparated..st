helper
toDotSeparated: aString
	| aux |
	aux := '_' asRegexIgnoringCase copy: aString replacingMatchesWith: '.'.
	^ aux asLowercase