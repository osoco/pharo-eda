code generation - test trait
generateTestHelperBuildEventMethodNameFromArbitraryFileWithFileArg: fileArg
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'EventFromFile: ' , fileArg