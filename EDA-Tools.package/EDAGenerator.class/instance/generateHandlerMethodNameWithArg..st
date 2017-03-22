code generation
generateHandlerMethodNameWithArg: arg
	| result cmdName |
	cmdName := self toCamelCase: self commandName.
	result := 'handle' , cmdName capitalized , ': ' , arg.
	^ result