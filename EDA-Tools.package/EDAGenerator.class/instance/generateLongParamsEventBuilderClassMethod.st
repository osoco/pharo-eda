code generation - event
generateLongParamsEventBuilderClassMethod
	| result eventClass methodName method attrs |
	eventClass := self retrieveEventClassName asSymbol.
	methodName := self generateEventBuilderClassMethodName.
	method := self
		generateEventBuilderClassMethodNameWithCommandArg: 'aCommandId'
		andParamsArg: 'params' , String cr.
	attrs := self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes.
	method := method , '    | result | ' , String cr.
	method := method , '    result := self new.' , String cr.
	method := method , '    result id: UUID new asString.' , String cr.
	method := method , '    result commandId: aCommandId.' , String cr.
	method := method , '    result aggregateRootClass: #' , self appName , self aggregate , '.'
		, String cr.
	method := method , '    result timestamp: DateAndTime now asUTC.' , String cr.
	attrs
		do: [ :attr | method := method , '    result ' , attr , ': (params at: #' , attr , ').' , String cr ].
	method := method , '    ^ result' , String cr.
	result := {(methodName -> method)} asDictionary.
	^ result