code generation - domain test
generateDomainTestMethodName
	| result cmdName |
	cmdName := self toCamelCase: self commandName.
	result := 'test' , cmdName.
	^ result