code generation
generateDomainTestEventClassBuilderMethod
	| method attrs result |
	method := self generateDomainTestEventClassBuilderMethodNameWithArgPrefix: 'event'.
	attrs := self retrieveEventAttributesBut: #('id').
	method := method , String cr , '    | result |' , String cr , '    result := self new.' , String cr.
	method := method , '    result id: eventId.' , String cr.
	method := method , '    result commandId: event commandId.' , String cr.
	method := method , '    result aggregateRootClass: #' , (self retrieveAggregateClassName) , '.', String cr.
	method := method , '    result aggregateRootVersion: ' , $' asString , '<ANYTHING>' , $' asString , '.' , String cr.
	method := method , '    result timestamp: ' , $' asString , '<ANYTHING>' , $' asString , '.'.
	attrs do: [ :attr | method := method , String cr , '    result ' , attr , ': event ' , attr , '.' ].
	method := method , String cr , '    ^ result'.
	result := {(self generateDomainTestEventClassBuilderMethodName -> method)} asDictionary.
	^ result