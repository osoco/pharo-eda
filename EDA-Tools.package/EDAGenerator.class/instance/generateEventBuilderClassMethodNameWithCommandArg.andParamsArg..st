code generation - event
generateEventBuilderClassMethodNameWithCommandArg: commandArg andParamsArg: paramsArg
	^ 'withCommandId: ' , commandArg , ' andParams: ' , paramsArg