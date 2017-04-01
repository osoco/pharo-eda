code generation - event
generateEventBuilderClassMethodName
	| eventClass result attrs |
	eventClass := self retrieveEventClassName asSymbol.
	result := 'withCommandId:'.
	attrs := self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes.
	attrs size > EDAGenerator maxMethodParams
		ifTrue: [ result := 'andParams:' ]
		ifFalse: [ attrs do: [ :attr | result := result , attr , ':' ] ].
	^ result