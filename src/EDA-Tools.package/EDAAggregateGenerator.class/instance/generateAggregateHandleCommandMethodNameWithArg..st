code generation
generateAggregateHandleCommandMethodNameWithArg: arg
	^ 'handle' , (self toCamelCase: self commandName) capitalized , ': ' , arg