code generation - test trait
generateReadEventFromFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile'