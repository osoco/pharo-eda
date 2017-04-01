code generation - command
generateCommandClassBuilderMethodNameWithCommandArg: commandArg andParamsArg: paramsArg
	^ 'withCommandId: ' , commandArg , ' andParams: ' , paramsArg
