code generation
generateDomainTestMethodName
	^ 'test' , (self toCamelCase: self commandName)