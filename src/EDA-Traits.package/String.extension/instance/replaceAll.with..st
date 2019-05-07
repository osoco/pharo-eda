*EDA-Traits
replaceAll: match with: replacement
	^ match greaseString asRegexIgnoringCase copy: self replacingMatchesWith: replacement