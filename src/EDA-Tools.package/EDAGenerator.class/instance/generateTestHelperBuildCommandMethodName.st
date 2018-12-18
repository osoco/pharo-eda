code generation - test trait
generateTestHelperBuildCommandMethodName
	^ 'build' , (self toCamelCase: self commandName) , 'SampleCommand'