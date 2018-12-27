code generation
generateTestHelperBuildDeleteEventMethodNameWithId: idArg andCommandArg: commandArg
	^ 'buildDeletedEventWithId: ' , idArg , ' andCommand: ' , commandArg