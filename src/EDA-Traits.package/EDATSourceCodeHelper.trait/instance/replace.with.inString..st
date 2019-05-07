helper
replace: match with: replacement inString: aString
	^ match asRegexIgnoringCase copy: aString replacingMatchesWith: replacement