code generation - test trait
generateTestHelperBuildCommandMethodName
	| result cmdName |
	cmdName := self toCamelCase: self commandName.
	result := 'build' , cmdName , 'SampleCommand'.
	^ result