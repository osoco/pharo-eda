code generation - command
generateCommandClassBuilderMethodNameWithCommandArg: commandArg andBlock: block
	| commandClass result attrs |
	commandClass := self retrieveCommandClassName asSymbol.
	result := 'withCommandId: ' , commandArg , ' '.
	attrs := self retrieveCommandAttributes.
	attrs do: [ :attr | result := result , attr , ': ' , (block cull: attr) , ' ' ].
	^ result