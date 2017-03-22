helper
retrieveCommandClassName
	^ self appName , (self toCamelCase: self commandName)