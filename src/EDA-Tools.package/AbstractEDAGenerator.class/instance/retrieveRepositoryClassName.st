helper
retrieveRepositoryClassName
	^ self appName , (self underscoreSeparatedToCamelCase: self aggregate) , 'Repository'