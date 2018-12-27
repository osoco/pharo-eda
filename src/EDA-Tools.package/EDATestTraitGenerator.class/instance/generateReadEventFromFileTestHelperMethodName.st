code generation
generateReadEventFromFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile'