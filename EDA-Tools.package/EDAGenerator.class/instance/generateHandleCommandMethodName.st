code generation - aggregate
generateHandleCommandMethodName
	^ 'handle' , (self toCamelCase: self commandName) capitalized , ':'