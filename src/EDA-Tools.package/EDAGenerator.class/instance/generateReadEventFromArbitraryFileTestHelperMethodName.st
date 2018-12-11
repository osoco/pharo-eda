code generation - test trait
generateReadEventFromArbitraryFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile:'