helper
retrieveVersion
	^ (self removePrefix: 'v' from: self commandFile parent basename) asInteger