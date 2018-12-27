code generation
generateTestHelperBuildEventFromArbitraryFileMethodName
	^ 'build' , (self toCamelCase: self eventName) , 'EventFromFile:'