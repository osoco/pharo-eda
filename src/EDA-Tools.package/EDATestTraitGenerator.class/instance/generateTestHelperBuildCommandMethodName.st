code generation
generateTestHelperBuildCommandMethodName
	^ 'build' , (self toCamelCase: self commandName) , 'SampleCommand'