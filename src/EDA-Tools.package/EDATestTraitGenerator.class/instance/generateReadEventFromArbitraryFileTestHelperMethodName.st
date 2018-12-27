code generation
generateReadEventFromArbitraryFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile:'