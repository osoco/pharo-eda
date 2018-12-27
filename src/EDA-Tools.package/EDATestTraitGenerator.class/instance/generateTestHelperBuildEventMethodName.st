code generation
generateTestHelperBuildEventMethodName
	^ 'build' , (self toCamelCase: self eventName) , 'SampleEventWithId:andCommandId:'