helper
retrieveAggregateIdNames
	^ self retrieveAggregateClasses
	select: [ :cls | (cls name greaseString beginsWith: self appName) ]
		thenCollect: [ :cls |
			((self remove: self appName fromBeginningOf: cls name greaseString) , 'Id') uncapitalized ]