helper
removePrefix: prefix from: value
	^ ('^' , prefix) asRegexIgnoringCase copy: value replacingMatchesWith: ''