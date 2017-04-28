code generation - test trait
generateTestHelperBuildEventMethodName
	^ 'build' , (self toCamelCase: self eventName) , 'SampleEventAndId:andCommand:'