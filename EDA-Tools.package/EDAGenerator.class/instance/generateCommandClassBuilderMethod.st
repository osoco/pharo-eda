code generation
generateCommandClassBuilderMethod
	| commandClass method attrs result |
	commandClass := self retrieveCommandClassName asSymbol.
	method := self generateCommandClassBuilderMethodNameWithArgPrefix: 'new'.
	attrs := self retrieveCommandAttributes.
	method := method , String cr , '    <' , appName asLowercase , 'CommandName: #' , self commandName , '>' , String cr , '    | result |' , String cr , '    result := ' , commandClass , ' new.'
		, String cr , '    result commandId: newCommandId.'.
	attrs do: [ :attr | method := method , String cr , '    result ' , attr , ': new' , attr capitalized , '.' ].
	method := method , String cr , '    ^ result'.
	result := {(self generateCommandClassBuilderMethodName -> method)} asDictionary.
	^ result