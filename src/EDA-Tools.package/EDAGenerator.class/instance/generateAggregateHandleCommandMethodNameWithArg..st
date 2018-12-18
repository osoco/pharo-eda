code generation - aggregate
generateAggregateHandleCommandMethodNameWithArg: arg
	^ 'handle' , (self toCamelCase: self commandName) capitalized , ': ' , arg