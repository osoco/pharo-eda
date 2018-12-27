code generation
generateReadCommandFromFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self commandName) , 'FromFile'