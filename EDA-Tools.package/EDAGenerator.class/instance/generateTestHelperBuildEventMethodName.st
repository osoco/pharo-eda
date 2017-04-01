code generation - test trait
generateTestHelperBuildEventMethodName
	| result cmdName |
	cmdName := self toCamelCase: self eventName.
	result := 'build' , cmdName , 'SampleEvent:'.
	^ result