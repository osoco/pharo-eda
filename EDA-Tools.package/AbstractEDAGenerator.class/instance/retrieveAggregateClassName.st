helper
retrieveAggregateClassName
	^ self appName , (self underscoreSeparatedToCamelCase: self aggregate)