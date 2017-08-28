code generation - test trait
generateTestHelperBuildEventFromArbitraryFileMethodNameWithFileArg: fileArg
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'EventFromFile: ' , fileArg