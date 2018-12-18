code generation - aggregate
generateAggregateHandleCommandMethodName
	^ 'handle' , (self toCamelCase: self commandName ) capitalized , ':'