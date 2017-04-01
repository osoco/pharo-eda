code generation - test trait
generateTestHelperBuildCommandMethod
	| method commandAttrs cmdName |
	commandAttrs := self retrieveCommandAttributes.
	cmdName := self toCamelCase: self commandName.
	method := self generateTestHelperBuildCommandMethodName.
	method := method , '    | commandMessage commandJson commandBody cmdCommandId'.
	commandAttrs do: [ :attr | method := method , ' cmd' , attr capitalized ].
	method := method , ' |' , String cr.
	method := method , '    commandMessage := self ' , self generateReadCommandFromFileTestHelperMethodName , '.' , String cr.
	method := method , '    commandJson := NeoJSONReader fromString: commandMessage.' , String cr.
	"	method := method , '    theCommandMessage := ' , $' asString , self commandRaw , $' asString , '.' , String cr."
	method := method , '    commandBody := commandJson at: #body.' , String cr.
	method := method , '    cmdCommandId := UUID new asString.' , String cr.
	commandAttrs
		do: [ :attr |
			method := method , '    cmd' , attr capitalized , ' := commandBody at: ' , $' asString , attr
				, $' asString , '.' , String cr ].
	method := method , '    ^ ' , self appName , cmdName , ' '
		, (self generateCommandClassBuilderMethodNameWithArgPrefix: 'cmd') , '' , String cr.
	^ method