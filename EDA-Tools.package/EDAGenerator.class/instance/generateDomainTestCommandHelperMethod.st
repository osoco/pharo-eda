code generation
generateDomainTestCommandHelperMethod
	| method commandAttrs cmdName |
	commandAttrs := self retrieveCommandAttributes.
	cmdName := self toCamelCase: self commandName.
	method := self generateDomainTestCommandHelperMethodName.
	method := method , '    | commandFile commandMessage commandJson commandBody cmdCommandId'.
	commandAttrs do: [ :attr | method := method , ' cmd' , attr capitalized ].
	method := method , ' |' , String cr.
	method := method , '    commandFile := (FileSystem disk workingDirectory / ' , $' asString , 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString , 'v1'
		, $' asString , ' / ' , $' asString , 'commands' , $' asString , ' / ' , $' asString , (self toDotSeparated: self commandName) , '.example.json' , $' asString , ') readStream.' , String cr.
	method := method , '    commandMessage := commandFile contents.' , String cr.
	method := method , '    commandJson := NeoJSONReader fromString: commandMessage.' , String cr.
	method := method , '    commandFile close.' , String cr.
	"	method := method , '    theCommandMessage := ' , $' asString , self commandRaw , $' asString , '.' , String cr."
	method := method , '    commandBody := commandJson at: #body.' , String cr.
	method := method , '    cmdCommandId := UUID new asString.' , String cr.
	commandAttrs do: [ :attr | method := method , '    cmd' , attr capitalized , ' := commandBody at: ' , $' asString , attr , $' asString , '.' , String cr ].
	method := method , '    ^ ' , self appName , cmdName , ' ' , (self generateCommandClassBuilderMethodNameWithArgPrefix: 'cmd') , '' , String cr.
	^ method