code generation
generateDomainTestEventHelperMethodName
	| result cmdName |
	cmdName := self toCamelCase: self eventName.
	result := 'build' , cmdName , 'SampleEvent:'.
	^ result