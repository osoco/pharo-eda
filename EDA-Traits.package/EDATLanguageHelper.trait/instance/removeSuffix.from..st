helper
removeSuffix: suffix from: value
	^ (suffix , '$') asRegexIgnoringCase copy: value replacingMatchesWith: ''