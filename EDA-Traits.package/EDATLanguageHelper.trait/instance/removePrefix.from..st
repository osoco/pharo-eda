helper
removePrefix: prefix from: value
	^ ('^' , prefix copyReplaceAll: ':' with: '\:') asRegexIgnoringCase copy: value replacingMatchesWith: ''