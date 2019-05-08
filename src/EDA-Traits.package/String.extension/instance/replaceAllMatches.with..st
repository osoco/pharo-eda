*EDA-Traits
replaceAllMatches: match with: replacement
	^ match greaseString asRegexIgnoringCase copy: self replacingMatchesWith: replacement greaseString