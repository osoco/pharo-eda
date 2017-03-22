code generation
generateCommandClassBuilderMethodNameWithCommandArg: commandArg andBlock: block
	| commandClass result attrs |
	commandClass := (self retrieveCommandClassName) asSymbol.
	result := 'withCommandId: ' , commandArg, ' '.
	attrs := self retrieveCommandAttributes.
	attrs
		doWithIndex: [ :attr :i | 
			| capitalized |
			capitalized := attr capitalized.
			result := result , attr , ': ' , (block cull: attr) , ' ' ].
	^ result