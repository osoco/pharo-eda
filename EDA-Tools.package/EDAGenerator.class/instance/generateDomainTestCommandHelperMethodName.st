code generation
generateDomainTestCommandHelperMethodName
	| result cmdName |
	cmdName := self toCamelCase: self commandName.
	result := 'build' , cmdName , 'SampleCommand'.
	^ result