code generation - command
generateLongParamsCommandBuilderClassMethod
	| commandClass method attrs result |
	commandClass := self retrieveCommandClassName asSymbol.
	method := self
		generateCommandClassBuilderMethodNameWithCommandArg: 'aCommandId'
		andParamsArg: 'params' , String cr.
	attrs := self retrieveCommandAttributes.
	method := method , '    <' , appName asLowercase , 'CommandName: #' , self commandName , '>'
		, String cr.
	method := method , '    | result |' , String cr.
	method := method , '    result := ' , commandClass , ' new.' , String cr.
	method := method , '    result commandId: aCommandId.' , String cr.
	attrs
		do: [ :attr | method := method , '    result ' , attr , ': (params at: #' , attr , ').' , String cr ].
	method := method , '    ^ result' , String cr.
	result := {(self generateCommandClassBuilderMethodName -> method)} asDictionary.
	^ result