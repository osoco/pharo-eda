code generation - test trait
generateTestHelperBuildEventFromArbitraryFileMethodName
	^ 'build' , (self toCamelCase: self eventName) , 'EventFromFile:'