code generation
checkerMethodName
	^ 'test' , (self underscoreSeparatedToCamelCase: self commandName)
		, 'RespectsContractV' , self version greaseString