helper
retrieveEventClassName
	^ self appName , (self toCamelCase: self eventName)