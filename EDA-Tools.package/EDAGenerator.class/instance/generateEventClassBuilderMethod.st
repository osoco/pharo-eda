code generation
generateEventClassBuilderMethod
	| result eventClass methodName method attrs |
	eventClass := self retrieveEventClassName asSymbol.
	methodName := self generateEventClassBuilderMethodName.
	method := self generateEventClassBuilderMethodNameWithArgPrefix: 'new'.
	attrs := self retrieveEventAttributesBut: (EDAGenerator skippedEventAttributes).
	method := method , String cr , '    | result | ' , String cr.
	method := method , '    result := self new.' , String cr.
	method := method , '    result id: UUID new asString.' , String cr.
	self flag: #TODO.	"This attributes are already in EDAGenerator skippedCommandAttributes"
	method := method , '    result commandId: newCommandId.' , String cr.
	method := method , '    result aggregateRootClass: #' , self appName , self aggregate , '.' , String cr.
	method := method , '    result timestamp: DateAndTime now asUTC.'.
	attrs do: [ :attr | method := method , String cr , '    result ' , attr , ': new' , attr capitalized , '.' ].
	method := method , String cr , '    ^ result'.
	result := {(methodName -> method)} asDictionary.
	^ result