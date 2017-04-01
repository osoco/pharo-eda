code generation - command
generateShortParamsCommandBuilderClassMethod
	| commandClass method attrs result |
	commandClass := self retrieveCommandClassName asSymbol.
	method := (self generateCommandClassBuilderMethodNameWithArgPrefix: 'new') , String cr.
	attrs := self retrieveCommandAttributes.
	method := method , '    <' , appName asLowercase , 'CommandName: #' , self commandName , '>'
		, String cr.
	method := method , '    | result |' , String cr.
	method := method , '    result := ' , commandClass , ' new.' , String cr.
	method := method , '    result commandId: newCommandId.' , String cr.
	attrs
		do: [ :attr | method := method , '    result ' , attr , ': new' , attr capitalized , '.' , String cr ].
	method := method , '    ^ result' , String cr.
	result := {(self generateCommandClassBuilderMethodName -> method)} asDictionary.
	^ result