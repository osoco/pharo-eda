code generation
generateAggregateHandleCommandMethodName
	^ 'handle' , (self toCamelCase: self commandName ) capitalized , ':'