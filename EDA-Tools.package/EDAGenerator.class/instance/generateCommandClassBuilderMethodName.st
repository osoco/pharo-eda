code generation - command
generateCommandClassBuilderMethodName
	| commandClass result attrs |
	commandClass := self retrieveCommandClassName asSymbol.
	result := 'withCommandId:'.
	attrs := self retrieveCommandAttributes.
	attrs size > EDAGenerator maxMethodParams
		ifTrue: [ result := result , 'andParams:' ]
		ifFalse: [ attrs doWithIndex: [ :attr :i | result := result , attr , ':' ] ].
	^ result