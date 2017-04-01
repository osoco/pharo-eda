code generation - aggregate
generateApplyEventMethodNameWithArg: arg
	| result evtName |
	evtName := self toCamelCase: self retrieveEventName.
	result := 'apply' , evtName capitalized , ': ' , arg.
	^ result