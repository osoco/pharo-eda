code generation - test trait
generateReadEventFromFileTestHelperMethod
	| method cmdName evtName eventAttrs |
	eventAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateReadEventFromFileTestHelperMethodName , String cr.
	method := method , '    | eventFile result |', String cr.
	method := method , '    eventFile := (FileSystem disk workingDirectory / ' , $' asString , 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString , 'v1' , $' asString , ' / ' , $' asString , 'events' , $' asString , ' / ' , $' asString , (self upcasedToDotSeparated: self eventName) , '.example.json' , $' asString , ') readStream.' , String cr.
	method := method , '    result := eventFile contents.' , String cr.
	method := method , '    eventFile close.' , String cr.
	method := method , '    ^ result' , String cr.
	^ method