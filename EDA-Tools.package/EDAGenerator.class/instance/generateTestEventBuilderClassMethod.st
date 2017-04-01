code generation - test support
generateTestEventBuilderClassMethod
	| method attrs result |
	method := self generateTestEventBuilderClassMethodNameWithArgPrefix: 'new'.
	attrs := self retrieveEventAttributesBut: #('id').
	method := method , String cr , '    | result |' , String cr , '    result := self new.' , String cr.
	method := method , '    result id: ' , $' asString , '<ANYTHING>' , $' asString , '.' , String cr.
	method := method , '    result commandId: newEvent commandId.' , String cr.
	method := method , '    result aggregateRootClass: #' , self retrieveAggregateClassName , '.' , String cr.
	method := method , '    result aggregateRootVersion: ' , $' asString , '<ANYTHING>' , $' asString , '.' , String cr.
	method := method , '    result timestamp: ' , $' asString , '<ANYTHING>' , $' asString , '.'.
	attrs do: [ :attr | method := method , String cr , '    result ' , attr , ': newEvent ' , attr , '.' ].
	method := method , String cr , '    ^ result'.
	result := {(self generateTestEventBuilderClassMethodName -> method)} asDictionary.
	^ result