code generation
generateIntegrationTestMethod
	| method cmdAttrs cmdName evtAttrs evtName |
	cmdAttrs := self retrieveCommandAttributes.
	evtAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateDomainTestMethodName.
	method := method , '    | theCommandId commandFile commandMessage commandJson commandBody eventFile expectedMessage expectedRoutingKey '.
	evtAttrs do: [ :attr | method := method , ' evt' , attr capitalized ].
	method := method , ' |' , String cr.
	method := method , '    commandFile := (FileSystem disk workingDirectory / ' , $' asString , 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString , 'v1'
		, $' asString , ' / ' , $' asString , 'commands' , $' asString , ' / ' , $' asString , (self toDotSeparated: self commandName) , '.example.json' , $' asString , ') readStream.' , String cr.
	method := method , '    commandMessage := commandFile contents.' , String cr.
	method := method , '    commandJson := NeoJSONReader fromString: commandMessage.' , String cr.
	method := method , '    commandFile close.' , String cr.
	method := method , '    theCommandId := UUID new asString.' , String cr.
	"	method := method , '    theCommandMessage := ' , $' asString , self commandRaw , $' asString , '.' , String cr."
	method := method , '    commandBody := commandJson at: #body.' , String cr.
	"attrs do: [ :attr | method := method , '    the' , attr capitalized , ' := commandBody at: ' , $' asString , attr , $' asString , '.' , String cr ]."
	method := method , '    eventFile := (FileSystem disk workingDirectory / ' , $' asString , 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString , 'v1'
		, $' asString , ' / ' , $' asString , 'events' , $' asString , ' / ' , $' asString , (self toDotSeparated: self eventName) , '.example.json' , $' asString , ') readStream.' , String cr.
	method := method , '    expectedMessage := eventFile contents.' , String cr.
	method := method , '    eventFile close.' , String cr.
	method := method , '    expectedRoutingKey := ' , $' asString , (self toDotSeparated: self eventName) , $' asString , '.' , String cr.
	method := method , '    self' , String cr.
	method := method , '        givenPreviousEvents: {}' , String cr.
	method := method , '        whenReceiveCommandMessage: commandMessage' , String cr.
	method := method , '        thenStoreEvent: (' , self appName , evtName , String cr.
	method := method , '            ' , (self generateEventClassBuilderMethodNameWithArgPrefix: 'evt') , ')' , String cr.
	method := method , '        andPublishEventMessage: expectedMessage' , String cr.
	method := method , '        withRoutingKey: expectedRoutingKey' , String cr.
	^ method