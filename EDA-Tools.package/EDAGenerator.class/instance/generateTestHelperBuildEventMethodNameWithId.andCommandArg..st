code generation - test trait
generateTestHelperBuildEventMethodNameWithId: idArg andCommandArg: commandArg
	^ 'build' , (self toCamelCase: self eventName ) , 'SampleEventWithId:' , idArg , ' andCommandId: ' , commandArg