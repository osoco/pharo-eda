code generation - domain test
generateDomainTestMethodName
	^ 'test' , (self toCamelCase: self commandName)