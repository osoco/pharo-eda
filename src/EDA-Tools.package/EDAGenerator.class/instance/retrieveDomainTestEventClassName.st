code generation - domain test
retrieveDomainTestEventClassName
	^ self appName , 'Test' , (self toCamelCase: self eventName)