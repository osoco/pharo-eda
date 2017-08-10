code generation - test trait
generateTestHelperBuildEventMethodName
	^ 'build' , (self toCamelCase: self eventName) , 'SampleEventWithId:andCommandId:'