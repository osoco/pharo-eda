removing
removeSuffix: suffix from: value
	^ ((suffix copyReplaceAll: ':' with: '\:') , '$') asRegexIgnoringCase copy: value replacingMatchesWith: ''