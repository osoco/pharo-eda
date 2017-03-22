code generation
generateHandlerMethodName
	^ 'handle' , (self toCamelCase: self commandName) capitalized , ':'