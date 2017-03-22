code generation
generateCommandClassBuilderMethodName
	| commandClass result attrs |
	commandClass := self retrieveCommandClassName asSymbol.
	result := 'withCommandId:'.
	attrs := self retrieveCommandAttributes.
	attrs
		doWithIndex: [ :attr :i |
			| capitalized |
			capitalized := attr capitalized.
			result := result , attr , ':' ].
	^ result