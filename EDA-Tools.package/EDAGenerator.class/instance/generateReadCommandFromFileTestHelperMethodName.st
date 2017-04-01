code generation - test trait
generateReadCommandFromFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self commandName) , 'FromFile'