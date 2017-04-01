code generation - event
generateShortParamsEventBuilderClassMethod
	| result eventClass methodName method attrs |
	eventClass := self retrieveEventClassName asSymbol.
	methodName := self generateEventBuilderClassMethodName.
	method := (self generateEventBuilderClassMethodNameWithArgPrefix: 'new') , String cr.
	attrs := self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes.
	method := method , '    | result | ' , String cr.
	method := method , '    result := self new.' , String cr.
	method := method , '    result id: UUID new asString.' , String cr.
	method := method , '    result commandId: newCommandId.' , String cr.
	method := method , '    result aggregateRootClass: #' , self appName , self aggregate , '.'
		, String cr.
	method := method , '    result timestamp: DateAndTime now asUTC.' , String cr.
	attrs
		do: [ :attr | method := method , '    result ' , attr , ': new' , attr capitalized , '.' , String cr ].
	method := method , '    ^ result' , String cr.
	result := {(methodName -> method)} asDictionary.
	^ result