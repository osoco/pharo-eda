code generation - test trait
generateReadEventFromFileTestHelperMethodName
	^ 'read' , (self toCamelCase: self retrieveEventName) , 'FromFile'