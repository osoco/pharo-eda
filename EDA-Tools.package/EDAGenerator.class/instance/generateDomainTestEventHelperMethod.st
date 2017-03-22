code generation
generateDomainTestEventHelperMethod
	| method cmdName evtName eventAttrs |
	eventAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateDomainTestEventHelperMethodNameWithCommandArg: 'commandId'.
	method := method , '    | evtCommandId eventFile eventMessage eventJson eventBody'.
	eventAttrs do: [ :attr | method := method , ' evt' , attr capitalized ].
	method := method , ' |' , String cr.
	method := method , '    eventFile := (FileSystem disk workingDirectory / ' , $' asString , 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString , 'v1'
		, $' asString , ' / ' , $' asString , 'events' , $' asString , ' / ' , $' asString , (self toDotSeparated: self eventName) , '.example.json' , $' asString , ') readStream.' , String cr.
	method := method , '    eventMessage := eventFile contents.' , String cr.
	method := method , '    eventJson := NeoJSONReader fromString: eventMessage.' , String cr.
	method := method , '    eventFile close.' , String cr.
	method := method , '    eventBody := eventJson at: #body.' , String cr.
	method := method , '    evtCommandId := commandId.' , String cr.
	eventAttrs do: [ :attr | method := method , '    evt' , attr capitalized , ' := eventBody at: ' , $' asString , attr , $' asString , '.' , String cr ].
	method := method , '    ^ ' , self appName , (self toCamelCase: self retrieveEventName) , ' ' , (self generateEventClassBuilderMethodNameWithArgPrefix: 'evt') , String cr.
	^ method