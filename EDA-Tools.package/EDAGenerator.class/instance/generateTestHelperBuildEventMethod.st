code generation - test trait
generateTestHelperBuildEventMethod
	| method cmdName evtName eventAttrs |
	eventAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateTestHelperBuildEventMethodNameWithCommandArg: 'commandId'.
	method := method , '    | evtCommandId eventMessage eventJson eventBody'.
	eventAttrs do: [ :attr | method := method , ' evt' , attr capitalized ].
	method := method , ' |' , String cr.
	method := method , '    eventMessage := self '
		, self generateReadEventFromFileTestHelperMethodName , '.' , String cr.
	method := method , '    eventJson := NeoJSONReader fromString: eventMessage.' , String cr.
	method := method , '    eventBody := eventJson at: #body.' , String cr.
	method := method , '    evtCommandId := commandId.' , String cr.
	eventAttrs
		do: [ :attr |
			method := method , '    evt' , attr capitalized , ' := eventBody at: ' , $' asString , attr
				, $' asString , '.' , String cr ].
	method := method , '    ^ ' , self appName , 'Test' , (self toCamelCase: self retrieveEventName)
		, String cr , '        fromEvent:' , String cr , '('
		, (self appName , (self toCamelCase: self retrieveEventName)) , ' '
		, (self generateEventBuilderClassMethodNameWithArgPrefix: 'evt') , ')' , String cr.
	^ method