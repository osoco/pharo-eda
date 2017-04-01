helper
retrieveAggregateClassName
	^ (self appName , (self toCamelCase: self aggregate))