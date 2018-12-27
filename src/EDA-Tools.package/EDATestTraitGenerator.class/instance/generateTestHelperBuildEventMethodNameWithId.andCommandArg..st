code generation
generateTestHelperBuildEventMethodNameWithId: idArg andCommandArg: commandArg
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'SampleEventWithId: ' , idArg , ' andCommandId: ' , commandArg