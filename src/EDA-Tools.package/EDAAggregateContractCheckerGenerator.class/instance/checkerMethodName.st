code generation
checkerMethodName
	^ 'testHandle' , (self underscoreSeparatedToCamelCase: commandName) , 'UsesTheExpectedEventBuilderV' , (self version asString)