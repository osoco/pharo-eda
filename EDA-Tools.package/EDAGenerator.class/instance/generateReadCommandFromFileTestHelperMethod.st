code generation - test trait
generateReadCommandFromFileTestHelperMethod
	| method cmdName evtName eventAttrs |
	eventAttrs := self retrieveCommandAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateReadCommandFromFileTestHelperMethodName , String cr.
	method := method , '    | commandFile result |' , String cr.
	method := method , '    commandFile := (FileSystem disk workingDirectory / ' , $' asString
		, 'contracts' , $' asString , ' / ' , $' asString , 'BBVA-ATS' , $' asString , ' / ' , $' asString
		, 'v1' , $' asString , ' / ' , $' asString , 'commands' , $' asString , ' / ' , $' asString
		, (self upcasedToDotSeparated: self commandName) , '.example.json' , $' asString , ') readStream.'
		, String cr.
	method := method , '    result := commandFile contents.' , String cr.
	method := method , '    commandFile close.' , String cr.
	method := method , '    ^ result' , String cr.
	^ method