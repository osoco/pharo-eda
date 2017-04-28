code generation
checkerMethodName
	^ 'test' , (self underscoreSeparatedToCamelCase: self eventName) , 'BuilderMethodRespectsContractV' , self version asString